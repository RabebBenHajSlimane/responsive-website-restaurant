pipeline {
    agent any

    environment {
        REGISTRY = "141119988/responsive-website-restaurant" // Remplacez par votre nom d'utilisateur Docker Hub
        REGISTRY_CREDENTIALS = 'dockerhub-credentials-id' // Remplacez par l'ID des credentials Docker Hub dans Jenkins
        KUBECONFIG_CREDENTIALS = 'kubeconfig-credentials-id' // Remplacez par l'ID des credentials kubeconfig
    }

    stages {
        stage('Checkout') {
            steps {
                // Utilisez ce dépôt local, ou configurez pour cloner depuis GitHub
                dir('/var/jenkins_home/temp_clone/responsive-website-restaurant') {
                     git 'https://github.com/RabebBenHajSlimane/responsive-website-restaurant.git'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${REGISTRY}:${env.BUILD_ID}")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', REGISTRY_CREDENTIALS) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withCredentials([file(credentialsId: KUBECONFIG_CREDENTIALS, variable: 'KUBECONFIG')]) {
                        sh '''
                        kubectl --kubeconfig=$KUBECONFIG apply -f k8s/deployment.yaml
                        '''
                    }
                }
            }
        }
    }
}
