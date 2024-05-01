pipeline {
    agent any
    environment {
        sonar_url   = "http://18.188.175.96:9000/"
        projectKey  = "springboothello"
        projectName = "springboot_project"
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
        // stage("Test") {
        //     steps {
        //         withCredentials([string(credentialsId: 'sonar-token', variable: 'token')]) {
        //             sh '''
        //                 mvn clean verify sonar:sonar \
        //                     -Dsonar.projectKey=${projectKey} \
        //                     -Dsonar.projectName=${projectName} \
        //                     -Dsonar.host.url=${sonar_url} \
        //                     -Dsonar.login=${token} \
        //                     -Dsonar.sourceEncoding=UTF-8 \
        //                     -Dsonar.sources=src \
        //                     -Dsonar.java.binaries=target/classes
        //             '''
        //         }
        //     }
        // }/
        stage("Test") {
            steps {
                withSonarQubeEnv(installationName: 'sonarqube', credentialsId: 'sonar-token') {
                    sh '''
                        ${ tool ("sonar-scanner")}/sonar-scanner \
                            -Dsonar.projectKey=hellospringboot \
                            -Dsonar.projectName=hellospringboot \
                            -Dsonar.sourceEncoding=UTF-8 \
                            -Dsonar.sources=src \
                            -Dsonar.java.binaries=target/classes
                    '''
                }
            }
        }
    }
}