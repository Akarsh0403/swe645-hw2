// Purpose: Automates building the Docker image and deploying it to the Rancher K8s cluster.
// Author: Sattu Akarsh Reddy

pipeline {
    agent any
    
    environment {
        // Matches the image name in your deployment.yaml
        DOCKER_IMAGE = 'akarshreddy0403/swe645-hw2:latest'
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                echo 'Building the Docker image...'
                sh 'docker build -t ${DOCKER_IMAGE} .'
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                echo 'Pushing image to Docker Hub...'
                // Uses credentials we will configure in Jenkins
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push ${DOCKER_IMAGE}'
                }
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                echo 'Deploying to Rancher Cluster...'
                // Jenkins uses the ~/.kube/config file we created earlier!
                sh 'kubectl apply -f deployment.yaml'
                sh 'kubectl apply -f service.yaml'
                
                // Forces the cluster to download the newest website code
                sh 'kubectl rollout restart deployment swe645-app-deployment'
            }
        }
    }
}