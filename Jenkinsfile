pipeline{
    agent any
    parameters {
        choice(name: 'MAVEN_GOAL', choices: ['install', 'package'], description: 'Select the Maven goal to execute')
    }
    stages{
        stage("Checkout"){
            steps{
                checkout scmGit(branches: [[name: '*/main']], 
                                extensions: [], 
                                userRemoteConfigs: [[url: 'https://github.com/Naresh240/springboot-webapplication.git']])
            }
        }
        stage("Build_Artifact"){
            steps{
                sh "mvn clean ${MAVEN_GOAL}"
            }
        }
    }
}
