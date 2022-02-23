pipeline {
    agent any
	
	  tools
    {
       maven "Maven 3.6.3"
    }
 stages {
      stage('checkout') {
           steps {
             
                git branch: 'master', url: 'https://github.com/devops4solutions/CI-CD-using-Docker.git'
             
          }
        }
	 stage('Execute Maven') {
           steps {
             
                sh 'mvn package'             
          }
        }
        

  stage('Docker Build and Tag') {
           steps {
              
                sh 'docker rmi -f samplewebapp:latest'
		sh 'docker build -t samplewebapp:latest .' 
                sh 'docker tag samplewebapp mohammedshashu/samplewebapp:latest'
                //sh 'docker tag samplewebapp mohammedshashu/samplewebapp:$BUILD_NUMBER'
               
          }
        }
     
  stage('Publish image to Docker Hub') {
          
            steps {
        withDockerRegistry([ credentialsId: "dockerHub", url: "" ]) {
          sh  'docker push mohammedshashu/samplewebapp:latest'
        //  sh  'docker push mohammedshashu/samplewebapp:$BUILD_NUMBER' 
        }
                  
          }
        }
     
      stage('Run Docker container on Jenkins Agent') {
             
            steps 
			{
                sh "docker rm -f sampleapp"
		sh "docker run -d --name sampleapp --restart=always -p 8003:8082 mohammedshashu/samplewebapp"
 
            }
        }
 stage('Run Docker container on remote hosts') {
             
            steps {
                sh "docker run -d sampleapp-remote --restart=always -p 8003:8083 mohammedshashu/samplewebapp"
		sh "docker ps | grep sampleapp" 
 
            }
        }
    }
	}
    
