# CQSS Ant to Maven Migration Documentation

## Overview
This document describes the migration process of the CQSS project from Ant to Maven. The migration was performed to modernize the build process, improve dependency management, and make the project more maintainable.

## Project Structure
The CQSS project consists of 14 modules:
1. CqssCommon - Common utilities and base classes
2. CqssStartup - Startup utilities
3. CqssVo - Value objects
4. CqssDB - Database access layer
5. CqssEjbUtil - EJB utilities
6. CqssBatchJobDB - Batch job database utilities
7. CqssApplet - Java applet module
8. CqssEjbTestClient - EJB test client
9. CqssIntraEjb - Intranet EJB module
10. CqssIntraEAR - Intranet EAR package
11. CqssIntranetWeb - Intranet web application
12. CqssSecurityAdmin - Security administration utilities
13. CqssSvr - Server module
14. Ibator - MyBatis generator module

## Migration Steps

### 1. Analysis of Ant Build Files
- Analyzed the original Ant build files to understand the build process
- Identified dependencies between modules
- Identified external dependencies
- Documented the build order and special build requirements

### 2. Setting Up Maven Project Structure
- Created a parent POM file with basic configuration
- Defined common properties and plugin management
- Set up multi-module structure
- Created module POMs with basic configuration

### 3. Configuring Dependencies
- Added internal dependencies between modules
- Added external dependencies from the Ant build files
- Configured system scope dependencies for proprietary libraries

### 4. Configuring Build Plugins
- Configured compiler plugin with appropriate Java version
- Configured JAR plugin for library modules
- Configured EJB plugin for EJB modules
- Configured WAR plugin for web modules
- Configured EAR plugin for enterprise application
- Configured resource filtering and copying

### 5. Testing the Build Process
- Created a setup script to prepare the build environment
- Built the project with Maven
- Verified that all artifacts were generated correctly

## Maven Configuration Details

### Parent POM
The parent POM (pom.xml) contains:
- Project coordinates and basic information
- Module declarations
- Common properties (Java version, encoding, etc.)
- Dependency management for all external dependencies
- Plugin management for all build plugins

### Module POMs
Each module POM contains:
- Module coordinates and basic information
- Dependencies on other modules and external libraries
- Build configuration specific to the module type

### Build Output
The build process generates the following artifacts in the lib/ejb directory:
- JAR files for all library modules
- EJB JAR files with client JARs
- WAR file for the web application
- EAR file for the enterprise application

## Special Considerations

### System Dependencies
The project uses several proprietary libraries that are not available in public Maven repositories. These are configured as system scope dependencies in the parent POM.

### EJB Configuration
The EJB modules are configured to generate client JARs and use the appropriate EJB version (2.1).

### Resource Filtering
Resource filtering is configured to exclude certain file types and include only the necessary resources in the build artifacts.

### Output Directories
The output directories are configured to match the original Ant structure, with all artifacts being placed in the lib/ejb directory.

## Build Instructions

### Prerequisites
- Java 1.6 or higher
- Maven 3.6.0 or higher
- Proprietary libraries in the lib directory

### Building the Project
1. Run the setup-build-env.sh script to prepare the build environment
2. Run `mvn clean install` to build the project
3. The build artifacts will be generated in the lib/ejb directory

## Conclusion
The migration from Ant to Maven has been successfully completed. The project now uses Maven for dependency management and build automation, making it more maintainable and easier to work with.

## Future Improvements
- Replace system scope dependencies with repository dependencies
- Add unit tests and configure the Surefire plugin
- Configure the Maven Release plugin for release management
- Add more documentation to the POMs
