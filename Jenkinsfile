pipeline {
    agent any
    environment {
        PROJECT_NAME = 'student-management-system'              // Your OpenShift project/namespace name
        IMAGE_NAME = 'student-management-app'     // Name of the application image
        GIT_REPO = 'https://github.com/bhavika2001/student_management.git' // Replace with your actual GitHub repository URL
        DOCKERFILE_PATH = 'C:\Users\bhavika.ajay.kotewar\Downloads\student_management-main\student_management-main\Dockerfile'            // Path to your Dockerfile (assumes it's in the root directory)
    }
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: "${GIT_REPO}" // Fetch code from GitHub
            }
        }
        stage('Build Image') {
            steps {
                script {
                    // Create a binary build in OpenShift using the Dockerfile
                    sh """
                    oc new-build --strategy=docker --binary --name=${IMAGE_NAME} -l app=${IMAGE_NAME} || true
                    oc start-build ${IMAGE_NAME} --from-dir=. --follow
                    """
                }
            }
        }
        stage('Deploy Application') {
            steps {
                script {
                    // Deploy the application using the built image
                    sh """
                    oc get dc/${IMAGE_NAME} || oc create deploymentconfig ${IMAGE_NAME} --image-stream=${IMAGE_NAME}
                    oc rollout latest dc/${IMAGE_NAME}
                    """
                }
            }
        }
        stage('Verify Deployment') {
            steps {
                script {
                    // Verify the deployment is successful
                    openshiftVerifyDeployment(deploymentConfig: "${IMAGE_NAME}", replicaCount: '1')
                }
            }
        }
    }
}
