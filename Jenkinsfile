pipeline {
     agent any
     
     tools {
     maven 'maven'
     }
     
     stages {
          
          stage('Git Clone') {
               steps {
                    git 'https://github.com/AnandMehta14/Docker.git'
               }
          }
         
          stage('Build') {
               steps {
                    sh 'mvn -Dmaven.test.failure.ignore=true clean package'
               }
          } 
          
          stage('Build Number') {
               steps {
                   echo "Build_Number:$BUILD_NUMBER"
               }
          } 
          
          
          stage('Docker Image') {
               steps {
                    sh label: '', script: '''docker build -t mehta14/java-project1:$BUILD_NUMBER .'''
                                 ///docker tag java-project1:$BUILD_NUMBER mehta14/java-project1:$BUILD_NUMBER'''                               
                               //  docker push mehta14/jb-hello-world:$BUILD_NUMBER''' 
                               
               }
          } 
          
          
          stage('Docker Image to DockerHub Repo') {
               steps {
                    sh label: '', script: '''docker push mehta14/java-project1:$BUILD_NUMBER''' 
               }
          } 
          
         /* stage('Deployment of Image in Production Server') {
                steps {
                    sh label: '', script: '''ssh jenkins@172.31.33.200 docker pull mehta14/java-project1:$BUILD_NUMBER
                                             ssh jenkins@172.31.33.200 docker rm -f my_project2 || true
                                             ssh jenkins@172.31.33.200 docker run -dit -p 8222:8080 --name my_project2 mehta14/java-project1:$BUILD_NUMBER''' 
                                             
                }
          }  
          */
          stage('Update Image Version') {
               steps {
                          sh label: '', script: '''sed -i s/latest/$BUILD_NUMBER/ my_deploy.yml'''

               }
          }
          
          stage('Connection to K8s') {
               steps {
                    sh label: '', script: ''' scp *.yml jenkins2@172.31.35.224:/home/jenkins2
                                              ssh jenkins2@172.31.35.224 kubectl apply -f my_deploy.yml
                                              ssh jenkins2@172.31.35.224 kubectl apply -f my_service.yml'''
               }
          }
     }
}
