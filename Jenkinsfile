pipeline {
    agent any
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
    }
}