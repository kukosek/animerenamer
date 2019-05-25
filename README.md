# animerenamer
Skript na hromadne meneni nazvu videi ve slozce ve ktere je skript ulozeny
Nazvy musi byt v nasledujicim tvaru:
Pokud by jsme nechali v nazvu pouze cisla, tak prvni tri musi byt nazev souboru a dalsi muze by 3-4 kvalita videa
Naprilad: [Mugiwara]One_Piece_691[720p_CZ][90EF81AC].mp4
Nebo: One Piece 022.avi

### Priklad
```
cd /home/anime/
chmod +x renamer.sh
./renamer.sh

Zadej prefix (napriklad sem napis nazev serialu) OP
Zadej sufix (napriklad nazev zdroje) MU GI
Zadej znak co bude oddelovat (napriklad _) _

OP_001_720p_MU GI.avi
Muze to byt napriklad takhle? (Y/N): Y
[Mugiwara]One_Piece_802[720p_CZ][F4ABE95E].mp4 --> OP_802_720p_MU GI.mp4
One Piece 017.mkv --> OP_017_MU GI.mkv
One Piece 020.avi --> OP_020_MU GI.avi
HorribleSubs_One_Piece_-_823_720p.ass --> OP_823_720p_MU GI.ass
Muzou byt soubory prejmenovany tak, jak bylo vypsano? TOTO NEJDE VRATIIT! (Y/N): Y
 Prejmenovano 4/4 souboru

```
