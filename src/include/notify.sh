# run it with notify 'Wrong path' 'path=./sds/ss.csv' 'xxxdddsduser'
function notify() {
  SUBJECT=$1
  BODY=$2
  TO_USER=$3

  `echo "${BODY}" | mail -s "${SUBJECT}" ${TO_USER}`
}


