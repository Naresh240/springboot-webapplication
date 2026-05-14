pipeline{
    agent any
    parameters {
        string(name: 'MAVEN_GOAL', defaultValue: '', description: 'Enter the maven goal to build the artifact')
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
