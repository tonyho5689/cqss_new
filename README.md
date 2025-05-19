# CQSS Ant to Maven Migration Guide

## 1. Prerequisites

- Java 1.8 or higher
- Maven 3.6.0 or higher
- Git installed (for repository management)

## 2. Initial Setup

1. **Clone the repository**:
   ```
   git clone https://github.com/tonyho5689/cqss_new.git
   cd cqss_new
   ```

2. **Set up the build environment**:

   For Windows:
   ```cmd
   setup-build-env.bat
   ```

   For Unix/Mac:
   ```bash
   chmod +x setup-build-env.sh
   ./setup-build-env.sh
   ```

   These scripts create necessary directories and placeholder files for system dependencies.

## 3. Project Structure Understanding

The project consists of 14 modules:
- Core modules: CqssCommon, CqssStartup
- Database modules: CqssVo, CqssDB, CqssEjbUtil, CqssBatchJobDB
- Client modules: CqssApplet, CqssEjbTestClient
- EJB modules: CqssIntraEjb
- Web modules: CqssIntranetWeb
- EAR modules: CqssIntraEAR
- Utility modules: CqssSecurityAdmin, CqssSvr, Ibator

## 4. Building the Project

### 4.1. Building the Entire Project

To build the entire project at once:
```
mvn clean install
```

This will:
- Clean previous build artifacts
- Compile all modules
- Package modules according to their packaging type (jar, war, ear, etc.)
- Install artifacts to your local Maven repository

### 4.2. Building Specific Modules

To build specific modules (similar to the original Ant scripts):

1. **Build Core Modules** (equivalent to BuildCqssCore.bat):
   ```
   mvn clean install -pl CqssCommon,CqssStartup
   ```

2. **Build EJB Modules** (equivalent to BuildCqssEjb.bat):
   ```
   mvn clean install -pl CqssVo,CqssDB,CqssEjbUtil,CqssIntraEjb
   ```

3. **Build Intranet Modules** (equivalent to BuildCqssIntranet.bat):
   ```
   mvn clean install -pl CqssIntranetWeb,CqssIntraEAR
   ```

4. **Build Client Modules** (equivalent to BuildCqssForClient.bat):
   ```
   mvn clean install -pl CqssApplet
   ```

## 5. Handling Dependencies

### 5.1. System Dependencies

The project uses several proprietary libraries configured as system dependencies in the parent POM. Before building, ensure these JAR files are available in the `lib` directory:

- AppCore.jar
- AppMsg.jar
- AppUtil.jar
- EjbCommon.jar
- EjbIntraCommonScs.jar
- HsmCommon.jar
- WnbLog.jar
- Startup.jar
- CyberUtilCommonForWas.jar
- CyberUtilToolsForWas.jar
- CyberUtilForWas.jar

If you have access to these libraries, replace the placeholder files created by the setup script with the actual JAR files.

### 5.2. External Dependencies

Maven will automatically download external dependencies like Apache Commons, Spring, and iBATIS from public repositories.

## 6. Module-Specific Build Instructions

### 6.1. EJB Modules

EJB modules are configured to generate client JARs. When building CqssIntraEjb, both the EJB JAR and client JAR will be generated:
```
mvn clean install -pl CqssIntraEjb
```

### 6.2. Web and EAR Modules

When building web and EAR modules, ensure that their dependencies are built first:
```
mvn clean install -pl CqssVo,CqssDB,CqssEjbUtil,CqssIntraEjb,CqssIntranetWeb,CqssIntraEAR
```

## 7. Build Output

After building, the artifacts will be available in:
- Each module's `target` directory
- Your local Maven repository (Windows: `C:\Users\{username}\.m2\repository\com\ocbc\hk\apps\cqss\`, Mac/Linux: `~/.m2/repository/com/ocbc/hk/apps/cqss/`)

## 8. Migrating Additional Modules

If you need to migrate additional modules:

1. Create a new module directory
2. Create a `pom.xml` file for the module
3. Add the module to the parent POM's `<modules>` section
4. Configure dependencies and build plugins as needed
5. Build and test the module

## 9. Testing the Migration

To verify that the migration was successful:

1. Build the entire project
2. Check that all expected artifacts are generated
3. Deploy the artifacts to your test environment
4. Test the functionality to ensure it matches the original Ant-built project

## 10. Troubleshooting Common Issues

### 10.1. Missing Dependencies

If you encounter missing dependency errors:
- Check that all system dependencies are available in the `lib` directory
- Verify that the paths in the `systemPath` elements are correct
- Ensure that all module dependencies are correctly declared

### 10.2. Build Failures

If a module fails to build:
- Check the error messages in the Maven output
- Verify that the module's source code is compatible with Java 1.8
- Ensure that all required resources are available

### 10.3. Packaging Issues

If the packaged artifacts don't match the expected structure:
- Review the configuration of the packaging plugins (jar, war, ear, ejb)
- Check the resource filtering and inclusion/exclusion patterns
- Compare the generated artifacts with the original Ant-built artifacts

## 11. Version Control

After successfully migrating and testing:

1. Commit your changes:
   ```
   git add .
   git commit -m "Complete Ant to Maven migration"
   ```

2. Push to the repository:
   ```
   git push origin main
   ```

## 12. Continuous Integration

Consider setting up a CI/CD pipeline to automate the build and testing process:
1. Configure a CI server (Jenkins, GitHub Actions, etc.)
2. Set up a build job that runs `mvn clean install`
3. Configure test execution and reporting
4. Set up deployment to test and production environments
