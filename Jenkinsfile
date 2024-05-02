pipeline {
    agent any
    environment {
        sonar_url   = "http://18.220.93.118:9000/"
        projectKey  = "springboothello"
        projectName = "springboot_project"
        // sonar_tool  = tool name: 'sonar-scanner', type: 'hudson.plugins.sonar.SonarRunnerInstallation'        
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
        stage("Push_Artifact_To_Nexus") {
            steps {
                nexusArtifactUploader artifacts: [[artifactId: 'mavewebappdemo', \
                                                    classifier: '', \
                                                    file: './target/mavewebappdemo-2.0.0-SNAPSHOT.war', \
                                                    type: 'war']], \
                                        credentialsId: 'nexus-creds', \
                                        groupId: 'com.tecmax.demo', \
                                        nexusUrl: '3.129.7.233:8081', \
                                        nexusVersion: 'nexus3', \
                                        protocol: 'http', \
                                        repository: 'maven-snapshots', \
                                        version: '2.0.0-SNAPSHOT'
            }
        }
    }
}