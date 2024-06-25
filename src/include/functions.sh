checkLastReturnCode() {
  returnCode=$?
  if [ $returnCode -ne 0 ]; then
      if [ -z "$NOTIFY_SUBJECT" ]; then
          NOTIFY_SUBJECT="Default subject";
      fi
      BODY=$1

      notify "${NOTIFY_SUBJECT}" "${returnCode}"
      exit 1
    fi
}
