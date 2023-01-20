#!/bin/bash
dec=( 1000 900 500 400 100 90 50 40 10 9 5 4 1 )
rom=( M CM D CD C XC L XL X IX V IV I )
function toDec (){ 

pos=`expr ${#num} - 1` 
prev=0 
result=0 
while [ $pos -ge 0 ];do 
case "${num:$pos:1}" in 
M) factor=1000 ;; 
D) factor=500 ;; 
C) factor=100 ;; 
L) factor=50 ;; 
X) factor=10 ;; 
V) factor=5 ;; 
I) factor=1 ;; 
esac 

if [ $factor -lt $prev ];then 
result=`expr $result - $factor` 
else 
result=`expr $result + $factor` 
fi 
prev=$factor 
pos=`expr $pos - 1` 
done
if [ $result -lt 2000 ]
then
    echo "El equivalente en decimal al numero romano $num es $result"
else
    echo "El numero esta fuera de rango"
fi
} 

function toRom (){ 

aux=$num 
pos=0 

for item in ${dec[@]};do 
valor=`expr $aux / $item` 
resto=`expr $aux % $item` 
cont=0 
while [ $cont -lt $valor ];do 
result=`echo $result${rom[$pos]}` 
cont=`expr $cont + 1` 
done 
pos=`expr $pos + 1` 
aux=$resto 
done
echo "El equivalente en números romanos al numero decimal $num es $result" 
} 

 
num=$1
tipoNum=2

validate='^-?[0-9]+([.][0-9]+)?$' 
if [[ $num =~ $validate ]]; then 
tipoNum=0
fi

 
if [ ${num:0:1} == "M" ] || [ ${num:0:1} == "D" ] || [ ${num:0:1} == "C" ] || [ ${num:0:1} == "V" ] || [ ${num:0:1} == "X" ] || [ ${num:0:1} == "I" ];then 
tipoNum=1
fi

if [ $tipoNum -eq 0 ]
    then
        if [ $num -gt 0 ] && [ $num -lt 2000 ]
        then
            toRom
        else
            echo "El numero no esta en el rango"
        fi
elif [ $tipoNum -eq 1 ]
    then
        toDec
else
    echo "No es un numero ni decimal ni romano"
fi
