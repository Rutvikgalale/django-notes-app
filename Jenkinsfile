pipeline {
    agent {label 'vinod'}
    stages{
        stage("git checkout"){
            steps{
                echo "this is cloning code"
                git branch: 'main', url: 'https://github.com/Rutvikgalale/django-notes-app_duplicate.git'
                echo "code cloned successful"
            }
        }
        stage("code build"){
            steps{
                echo "This is building code"
                sh 'docker build -t notes-app:latest .'
                echo "docker build successfull"
            }
        }
        stage("code Test"){
            steps{
                echo "This is testing code"
            }
        }
        stage("push image to Dockerhub") {
            steps {
                echo "pushing image to docker Hub"
                withCredentials([usernamePassword(credentialsId: "DockerHubcred", passwordVariable: "DockerHubPass", usernameVariable: "DockerHubUser")]) {
                sh '''
                echo "USER=$DockerHubUser"
                echo "PASS length=${#DockerHubPass}"
                docker login -u $DockerHubUser -p $DockerHubPass
                docker tag notes-app:latest $DockerHubUser/notes-app:latest
                docker push $DockerHubUser/notes-app:latest
            '''
                }
            }
        }
        stage("code Deploy"){
            steps{
                echo "This is Deploying code"
                sh '''
                 # Stop old container by name if exists
                 #docker stop notes-app || true
                 #docker rm notes-app || true
                 # Stop any container occupying port 8000
                 old=$(docker ps -aq --filter "publish=8000")
                 if [ -n "$old" ]; then
                 echo "Stopping containers using port 8000..."
                 docker stop $old || true
                 docker rm $old || true
                 fi
                 /usr/bin/docker run -dit -p 8000:8000 notes-app:latest  
                 '''
            }
        }
    }
}
