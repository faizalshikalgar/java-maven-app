pipeline{
    agent any
    tools{
        maven 'Maven'
    }
    stages{
	stage("Test"){
            steps{
                script {
                  echo "Testing code"
                }
            }    
        }

        stage("Build jar"){
	   when{
		expression {
			BRANCH_NAME == 'master'
			    }
 		}
            steps{
                script {
                  echo "Building the application..."
                  sh 'mvn package'
                }
            }    
        }
        stage("build image"){
	  when{
		expression {
			BRANCH_NAME == 'master'
			    }
 		}
            steps{
                script {
                    echo "Building the docker image..."
                    withCredentials([usernamePassword(credentialsId: 'docker-hubrepo', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh 'docker build -t faizalshikalgar/demo-app:jma-1.0 .'
                        sh "echo $PASS | docker login -u $USER --password-stdin"
                        sh 'docker push faizalshikalgar/demo-app:jma-1.0'
                        }
                }        
            }    
        }
        
    }
}
