checkLastReturnCode() {
  returnCode=$?
  if [ $returnCode -ne 0 ]; then
      if [ -z "$1" ]; then
          1="Default";
      fi
      if [ -z "$2" ]; then
          2="No error description";
      fi
      TOPIC=$1
      BODY=$2

      notify "${TOPIC}" "${BODY}" "${USER}"
      exit 1
    fi
}
