def gv
pipeline{
    agent any
    tools{
        maven 'Maven'
    }
    stages{
        stage("init"){
            steps {
                script {
                    gv = load "script.groovy"
                }
            }
        }
        stage("Build jar"){
            when{
                expression{
                    BRANCH_NAME == "master'
                }
            }
            steps{
                script {
                  gv.buildJar()
                }
            }    
        }
        stage("build image"){
            steps{
                script {
                    gv.buildIamge()
                }        
            }    
        }
        stage("Deploy"){
            steps{
                script {
                  gv.deployApp()
                }
            }    
        }
        
    }
}
