pipeline {
    agent any
    stages {
        stage('Build on Slave when its online') {
            steps {
                script {
                  sh "docker build . -t vsnaresh/web:2.0.2"
                }
            }
        }
        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-crede', passwordVariable: 'dhubPwd', usernameVariable: 'dhubUser')]) {
                    sh "docker login -u ${dhubUser} -p ${dhubPwd}"
                    sh "docker push vsnaresh/web:2.0.2"
                }
            }
        }
        // stage('Docker Deploy') {
        //     steps {
        //         sshagent(['docker-login']) {
        //             sh "ssh -o StrictHostKeyChecking=no  ec2-user@172.31.8.121 docker rm -f hiring"
        //             sh "ssh  ec2-user@172.31.8.121 docker run -d -p 8090:8080 --name hiring vsnaresh/web:1.0.7"
        //         }
                
        //     }
        // }
    }
}
