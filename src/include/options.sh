SILENT_MODE=0


while getopts e:f:s opts; do
   case ${opts} in
      s) SILENT_MODE=1 ;;
      e)
        if [ ${OPTARG} == "dump" ]; then
          echo "Skipped step dumping db on source server"
          DUMP=0;
        fi
        if [ ${OPTARG} == "copy" ]; then
          echo "Skipped step copying db from source server"
          COPY=0;
        fi
        if [ ${OPTARG} == "prepare" ]; then
          echo "Skipped step preparing dump file to import"
          PREPARE_IMPORT_FILE=0;
        fi
        if [ ${OPTARG} == "import" ]; then
          echo "Skipped step import file"
          IMPORT=0;
        fi
        ;;
      f)
        FILENAME=${OPTARG} ;;
   esac
done
