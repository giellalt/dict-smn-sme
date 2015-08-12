
# Dette skal bli ei makefil for å lage smnsme.fst, 
# ei fst-fil som tar sme og gjev ei fin-omsetjing.

# Førebels er det berre eit shellscript.

echo ""
echo ""
echo "---------------------------------------------------"
echo "Shellscript to make a transducer of the dictionary."
echo ""
echo "It writes a lexc file to bin, containing the line	 "
echo "LEXICON Root										 "
echo "Thereafter, it picks lemma and first translation	 "
echo "of the dictionary, adds them to this lexc file,	 "
echo "and compiles a transducer bin/smnsme.fst		 "
echo ""
echo "Usage:"
echo "lookup bin/smnsme.fst"
echo "---------------------------------------------------"
echo ""
echo ""

echo "LEXICON Root" > bin/smnsme.lexc
cat src/*_smnsme.xml | \
grep '^ *<[lt][ >]'  | \
sed 's/^ *//g;'      | \
sed 's/<l /™/g;'     | \
tr '\n' '£'          | \
sed 's/£™/€/g;'      | \
tr '€' '\n'          | \
tr '<' '>'           | \
cut -d'>' -f2,6      | \
tr '>' ':'           | \
tr ' ' '_'           | \
sed 's/$/ # ;/g;'    >> bin/smnsme.lexc        

#xfst -e "read lexc < bin/smnsme.lexc"

printf "read lexc < bin/smnsme.lexc \n\
invert net \n\
save stack bin/smnsme.fst \n\
quit \n" > tmpfile
xfst -utf8 < tmpfile
rm -f tmpfile
