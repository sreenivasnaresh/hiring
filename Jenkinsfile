pipeline {
    agent{
        label 'Linux1'
    }
    stages {
        // stage('Maven Build') {
        //     steps {
        //         sh "mvn clean package"
        //     }
        // }
        
        stage('Docker Build') {
            steps {
                sh "docker build . -t vsnaresh/web:1.0.6"
            }
        }
        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-crede', passwordVariable: 'dhubPwd', usernameVariable: 'dhubUser')]) {
                    sh "docker login -u ${dhubUser} -p ${dhubPwd}"
                    sh "docker push vsnaresh/web:1.0.6"
                }
            }
        }
        stage('Docker Deploy') {
            steps {
                sshagent(['docker-login']) {
                    sh "ssh -o StrictHostKeyChecking=no  ec2-user@172.31.8.121 docker rm -f hiring"
                    sh "ssh  ec2-user@172.31.8.121 docker run -d -p 8090:8080 --name hiring vsnaresh/web:1.0.6"
                }
                
            }
        }

    }
}

// def commit_id(){
//     id = sh returnStdout: true, script: 'git rev-parse HEAD'
//     return id
// }
