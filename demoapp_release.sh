OTML_GITHUB_DEMO_APP="../../GITHUB/automatid_ios_demo"
DEMO_APP_FOLDER_COPY="../Releases/temp/demo_app_copy"

mkdir ${DEMO_APP_FOLDER_COPY}
cp . ${DEMO_APP_FOLDER_COPY}

rm ${DEMO_APP_FOLDER_COPY}/Podfile
mv ${DEMO_APP_FOLDER_COPY}/Podfile-Release ${DEMO_APP_FOLDER_COPY}/Podfile

