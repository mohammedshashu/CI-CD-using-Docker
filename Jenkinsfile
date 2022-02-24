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
             
                sh 'mvn clean sonar:sonar -Dsonar.login=b5f0f67afafe6d825ecd4cdcd90cef60e216dea0'
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

    stage('Executing Testcase') {
           steps {
                git branch: 'master', url: 'https://github.com/mohammedshashu/example.java.helloworld.git'
		   
                sh 'javac HelloWorld/Main.java'
		sh 'java -cp . HelloWorld.Main'
		sh 'jar cfme Main.jar Manifest.txt HelloWorld.Main HelloWorld/Main.class'
                sh 'java -jar Main.jar'
          }
        }
     
      stage('Run Docker container on Jenkins Agent') {
             
            steps 
			{
                sh "docker rm -f sampleapp"
		sh "docker run -d --name sampleapp --restart=always -p 8003:8080 mohammedshashu/samplewebapp"
 
            }
        }
 stage('Run Docker container on remote hosts') {
             
            steps {	
		 sh "docker rm -f sampleapp-remote"
                 sh "docker run -d --name sampleapp-remote --restart=always -p 8004:8080 mohammedshashu/samplewebapp"
		 sh "docker ps | grep sampleapp" 
 
            }
        }
    }
	}
    
