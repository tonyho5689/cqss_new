CQSS build scripts instruction as below:
1. BuildCqssCore.bat:
   a. It will build projects: CqssStartup, CqssCommon
   b. The name of build output log: BuildCqssCore.log
   c. The jars of build output: CqssStartup.jar, CqssCommon.jar
2. BuildCqssEjb.bat:
   a. It will build projects: CqssVo, CqssDB, CqssEjbUtil, CqssIntraEjb
   b. The name of build output log: BuildCqssEjb.log
   c. The jars of build output: CqssVo.jar, CqssDB.jar, CqssEjbUtil.jar, CqssIntraEjb.jar, CqssIntraEjbStub.jar
3. BuildCqssIntranet.bat:
   a. It will build projects: CqssIntranetWeb
   b. The name of build output log: BuildCqssIntranet.log
   c. The jars/ear of build output: CqssIntranetWeb.jar, CqssIntra.ear
4. BuildCqssForWas.bat:
   a. It will call the build scripts: BuildCqssCore.bat, BuildCqssEjb.bat, BuildCqssIntranet.bat
   b. The name of build output log: BuildCqssForWas.log
5. BuildCqssForClient.bat:
   a. It will build projects: CqssApplet
   b. The name of build output log: BuildCqssForClient.log
   c. The jars of build output: CqssApplet.jar
6. BuildCqssForServer.bat:
   a. It will build projects:
   b. The name of build output log: BuildCqssForServer.log
   c. The jars/ear of build output:

PS.:
a. If update CqssApplet's project, should call BuildCqssForClient.bat and sign the jar. And then call BuildCqssIntranet.bat as include the new CqssApplet.jar to the CqssIntra.ear