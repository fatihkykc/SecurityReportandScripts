file=$1
if [[ ! -f ${file##*/} ]]; then

	cd $file
	find . -exec md5sum {} \; | grep -v Tag | sort > ~/NETSEC/${file##*/}
	cd -
else
	cd $file
	newMD5s="$(find . -exec md5sum {} \; | sort)"
	newMD5s=${newMD5s}
	#echo "$newMD5s" > ~/NETSEC/new_${file##*/}
	diff ~/NETSEC/${file##*/} <(echo "$newMD5s")
	cd -
fi
