pipeline {
    agent any
    environment {
        // Sonar Variables
        sonar_url   = "http://18.220.93.118:9000/"
        projectKey  = "springboothello"
        projectName = "springboot_project"
        // sonar_tool  = tool name: 'sonar-scanner', type: 'hudson.plugins.sonar.SonarRunnerInstallation'   

        //Nexus Variables
        NEXUS_VERSION = "nexus3"
        NEXUS_PROTOCOL = "http"
        NEXUS_URL = "3.129.7.233:8081"
        NEXUS_REPOSITORY = "maven-snapshots"
        NEXUS_CREDENTIAL_ID = "nexus-creds"             
    }
    stages {
        stage("Checkout") {
            steps {
                git branch: 'jenkins', 
                    url: 'https://github.com/Naresh240/springboot-webapplication.git'
            }
        }
        stage("Build_Artifact") {
            steps {
                sh "mvn clean package"
            }
        }
        stage("Test") {
            steps {
                withCredentials([string(credentialsId: 'sonar-token', variable: 'token')]) {
                    sh '''
                        mvn clean verify sonar:sonar \
                            -Dsonar.projectKey=${projectKey} \
                            -Dsonar.projectName=${projectName} \
                            -Dsonar.host.url=${sonar_url} \
                            -Dsonar.login=${token} \
                            -Dsonar.sourceEncoding=UTF-8 \
                            -Dsonar.sources=src \
                            -Dsonar.java.binaries=target/classes
                    '''
                }
            }
        }
        // stage("Test") {
        //     steps {
        //         withSonarQubeEnv(installationName: 'sonarqube', credentialsId: 'sonar-token') {
        //             sh "${sonar_tool}/sonar-scanner \
        //                     -Dsonar.projectKey=hellospringboot \
        //                     -Dsonar.projectName=hellospringboot \
        //                     -Dsonar.sourceEncoding=UTF-8 \
        //                     -Dsonar.sources=src \
        //                     -Dsonar.java.binaries=target/classes"
        //         }
        //     }
        // }
        stage("Push_Artifacts_To_Nexus") {
            steps {
                script{
                    pom = readMavenPom file: "pom.xml";
                    filesByGlob = findFiles(glob: "target/*.${pom.packaging}");
                    echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
                    artifactPath = filesByGlob[0].path;
                    artifactExists = fileExists artifactPath;
                    if(artifactExists) {
                        echo "* File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version}";
                        nexusArtifactUploader(
                            nexusVersion: NEXUS_VERSION,
                            protocol: NEXUS_PROTOCOL,
                            nexusUrl: NEXUS_URL,
                            groupId: pom.groupId,
                            version: pom.version,
                            repository: NEXUS_REPOSITORY,
                            credentialsId: NEXUS_CREDENTIAL_ID,
                            artifacts: [
                                [artifactId: pom.artifactId,
                                classifier: '',
                                file: artifactPath,
                                type: pom.packaging],
                                [artifactId: pom.artifactId,
                                classifier: '',
                                file: "pom.xml",
                                type: "pom"]
                            ]
                        );
                    } else {
                        error "* File: ${artifactPath}, could not be found";
                    }
                }
            }
        }
    }
}