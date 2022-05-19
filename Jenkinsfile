#!/usr/bin/env groovy

pipeline{
    agent any
    tools{
        maven 'Maven'
    }
    stages{
        stage("increment version"){
            steps{
                script {
                  echo "incrementing app version..."
                  sh 'mvn build-helper:parse-version versions:set \
                    -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nextIncrementalVersion} \
                    versions:commit'
                  def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
                  def version = matcher[0][1]
                  env.IMAGE_NAME = "$version-$BUILD_NUMBER"
                  echo "$env.IMAGE_NAME"
                }
            }    
        }
        stage("Build app"){
            steps{
                script {
                  echo "building the application"
                  sh "mvn clean package"
                }
            }    
        }
        stage("build image"){
            steps{
                script {
                    echo "building the docker image..."
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-repo', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh "echo $PASS | docker login -u $USER --password-stdin"
                        sh "docker build -t faizalshikalgar/demo-app:${env.IMAGE_NAME} ."
                        sh "docker push faizalshikalgar/demo-app:${env.IMAGE_NAME}"
                    }
                }        
            }    
        }
        stage("Deploy"){
            steps{
                script {
                    echo "deploying the application..."
                    
                    def shellCmd = "bash ./server-cmds.sh ${env.IMAGE_NAME}"
                    def ec2Instance =  "ec2-user@******"
                    
                    sshagent(['ec2-server-key']) {
                        sh "scp server-cmds.sh ${ec2Instance}:/home/ec2-user"
                        sh "scp docker-compose.yaml ${ec2Instance}:/home/ec2-user"
                        sh "ssh -o StrictHostKeyChecking=no ${ec2Instance} &{shellCmd}
                        }
                    }
               }    
        }
        stage('commit version update') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'github-credentials', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh 'git status'
                        sh 'git branch'
                        sh 'git config --list'
                        
                        sh "git remote set-url origin https://${USER}:${PASS}@github.com/faizalshikalgar/java-maven-app.git"
                        sh 'git add .'
                        sh 'git commit -m "ci: version bump"'
                        sh 'git push origin HEAD:newfeature'
                    }
                }
            }
        }
        
    }
}
