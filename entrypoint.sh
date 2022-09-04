for f in /docker-entrypoint-initdb.d/*; do 
 	case "$f" in 
 		*.sh) 
 			# https://github.com/docker-library/postgres/issues/450#issuecomment-393167936 
 			# https://github.com/docker-library/postgres/pull/452 
 			if [ -x "$f" ]; then 
 				echo "$0: running $f" 
 				"$f" 
 			else 
 				echo "$0: sourcing $f" 
 				. "$f" 
 			fi 
 			;; 
 		*.sql)    echo "$0: running $f"; "${psql[@]}" -f "$f"; echo ;; 
 		*.sql.gz) echo "$0: running $f"; gunzip -c "$f" | "${psql[@]}"; echo ;; 
 		*)        echo "$0: ignoring $f" ;; 
 	esac 
 	echo 
 done 