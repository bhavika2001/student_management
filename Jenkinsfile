pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/bhavika2001/student_management.git'
        GIT_BRANCH = 'main'
        MAVEN_HOME = 'C:\\Users\\bhavika.ajay.kotewar\\Downloads\\apache-maven-3.9.5-bin\\apache-maven-3.9.5'
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    // Clone the repository from GitHub using the token
                    git branch: "${GIT_BRANCH}", url: "${GIT_REPO}"
                }
            }
        }

        stage('Build Application') {
            steps {
                script {
                    // Use Maven to build the project
                    bat "\"${MAVEN_HOME}\\bin\\mvn\" clean package -DskipTests"
                }
            }
        }

        stage('Run Application Locally') {
            steps {
                script {
                    // Run the application locally (if required)
                    bat 'start java -jar target/*.jar > app.log 2>&1'
                }
            }
        }
    }

    post {
        success {
            echo 'Application built and running locally on http://localhost:8080!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}
