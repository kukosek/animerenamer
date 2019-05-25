#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR
if [ $(dpkg-query -W -f='${Status}' util-linux 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  if [ "$EUID" -ne 0 ]
  then echo "Spust me znova jako ROOT, abych mohl nainstalovat potrebny balicek rename.ul"
  exit
  fi
  apt-get install util-linux;
fi


echo "ANIMERENAMER"
echo "Skript na hromadne meneni nazvu videi ve slozce ve ktere je skript ulozeny"
echo "Nazvy musi byt v nasledujicim tvaru:"
echo "Pokud by jsme nechali v nazvu pouze cisla, tak prvni tri musi byt nazev souboru a dalsi muze by 3-4 kvalita videa"             
echo "Naprilad: [Mugiwara]One_Piece_691[720p_CZ][90EF81AC].mp4"
echo "Nebo: One Piece 022.avi"
echo ""
echo ""              

read -p "Zadej prefix (napriklad sem napis nazev serialu) " prefix
read -p "Zadej sufix (napriklad nazev zdroje) " sufix
read -p "Zadej znak co bude oddelovat (napriklad _) " separator
echo ""
echo $prefix$separator"001"$separator"720p"$separator$sufix".avi"
read -p "Muze to byt napriklad takhle? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
pocetSouboru=0
for filepath in $DIR/*.mp4 $DIR/*.mkv $DIR/*.avi $DIR/*.ass; do
    pocetSouboru=$((pocetSouboru+1))
    FILENAME=${filepath:${#DIR}+1}
    KONCOVKA=${FILENAME: -4}
    NUMBER=$(echo $FILENAME | tr -dc '0-9')
    DIL=${NUMBER:0:3}
    KVALITA=${NUMBER:3:3}
    if [ ${#KVALITA} -gt 2 -a ${#KVALITA} -lt 5 ]
    then
        KVALITA="${KVALITA}p"
    else
	KVALITA="null"
    fi

    if [ $KVALITA == "108p" ]
    then
	KVALITA="1080p"
    fi
   
    if [ $KVALITA == "null" ]
    then
	echo "$FILENAME --> $prefix$separator$DIL$separator$sufix$KONCOVKA"
    else
        echo "$FILENAME --> $prefix$separator$DIL$separator$KVALITA$separator$sufix$KONCOVKA"
    fi
done
read -p "Muzou byt soubory prejmenovany tak, jak bylo vypsano? TOTO NEJDE VRATIIT! (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1


pocetRename=0
echo "Prejmenovano ${pocetRename}/$pocetSouboru souboru"
for filepath in $DIR/*.mp4 $DIR/*.mkv $DIR/*.avi $DIR/*.ass; do
    pocetRename=$((pocetRename+1))
    FILENAME=${filepath:${#DIR}+1}
    KONCOVKA=${FILENAME: -4}
    NUMBER=$(echo $FILENAME | tr -dc '0-9')
    DIL=${NUMBER:0:3}
    KVALITA=${NUMBER:3:3}
    if [ ${#KVALITA} -gt 2 -a ${#KVALITA} -lt 5 ]
    then
        KVALITA="${KVALITA}p"
    else
	KVALITA="null"
    fi

    if [ $KVALITA == "108p" ]
    then
	KVALITA="1080p"
    fi
   
    if [ $KVALITA == "null" ]
    then
	command=(rename.ul "$FILENAME" "$prefix$separator$DIL$separator$sufix$KONCOVKA" *)
	"${command[@]}"	
    else
        command=(rename.ul "$FILENAME" "${prefix}$separator$DIL$separator$KVALITA$separator$sufix$KONCOVKA" *)
	"${command[@]}"
    fi
    echo -en "\e[1A"; echo -e "\e[0K\r Prejmenovano ${pocetRename}/$pocetSouboru souboru"
done
echo ""
echo "Hotovo."
