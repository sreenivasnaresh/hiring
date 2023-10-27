pipeline {
    agent any
    // agent{
    //     label 'Linux1'
    // }
    stages {
        stage('Build on Slave when its online') {
            steps {
                script{
                 def slaveNode = Jenkins.instance.getNode('Linux1')
                    
                    if (slaveNode != null && slaveNode.toComputer().online) {
                        currentBuild.agent = label 'Linux1' // Run on the slave if it's online
                    }   
                }
                
                //git branch: 'main', credentialsId: '3f038be7-ca0a-4c0d-bc0d-8e27d692c28e', url: 'https://github.com/sreenivasnaresh/hiring'
                sh "docker build . -t vsnaresh/web:1.0.8"
            }
        }
        stage('Build on Master when agent is Offline') {
            // when {
            //     expression {
            //         def node = Jenkins.instance.getComputer("Linux1")
            //         return node == null || !node.isOnline()
            //     }
            // }
            // agent any
            steps {
                //git branch: 'main', credentialsId: '3f038be7-ca0a-4c0d-bc0d-8e27d692c28e', url: 'https://github.com/sreenivasnaresh/hiring'
                sh "docker build . -t vsnaresh/web:1.0.8"
            }
        }
        
        // stage('Docker Build') {
        //     steps {
        //         sh "docker build . -t vsnaresh/web:1.0.8"
        //     }
        // }
        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-crede', passwordVariable: 'dhubPwd', usernameVariable: 'dhubUser')]) {
                    sh "docker login -u ${dhubUser} -p ${dhubPwd}"
                    sh "docker push vsnaresh/web:1.0.8"
                }
            }
        }
        stage('Docker Deploy') {
            steps {
                sshagent(['docker-login']) {
                    sh "ssh -o StrictHostKeyChecking=no  ec2-user@172.31.8.121 docker rm -f hiring"
                    sh "ssh  ec2-user@172.31.8.121 docker run -d -p 8090:8080 --name hiring vsnaresh/web:1.0.7"
                }
                
            }
        }

    }
}

// def commit_id(){
//     id = sh returnStdout: true, script: 'git rev-parse HEAD'
//     return id
// }
