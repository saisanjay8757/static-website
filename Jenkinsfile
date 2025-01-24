pipeline{
    agent any
    /*tools{
        jdk 'jdk17'
        terraform 'Terraform'
    }*/
    environment {
        SCANNER_HOME=tool 'snaorqube-scanner'
    }
    stages{
        stage('clean workspace'){
            steps{
                cleanWs()
            }
        }
        stage('check from git'){
            steps{
                git branch: 'main', url: 'https://github.com/saisanjay8757/static-website.git'

            }
        }
        stage('Terraform Version'){
            steps{
                sh 'terraform --version'
            }
        }
        stage("sonarqube Analysis"){
            steps{
                withSonarQubeEnv('snaorqube'){
                    sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=Terraform \
                    -Dsonar.projectKey=Terraform '''
                }
            }
        }
        stage("quality gate"){
            steps{
                script{
                    waitForQualityGate abortPipeline: true, timeout: '10', credentialsId: 'snaorqube' 
                }
            }
        }
        stage('TRIVY FS SCAN'){
            steps{
                sh "trivy fs . > trivyfs.txt"
            }
        }
        stage('Excutable permission to userdata'){
            steps{
                sh 'chmod 777 website.sh'
            }
        }
        stage('terraform init'){
            steps{
                sh 'terraform init'
            }
        }
        stage('terraform plan'){
            steps{
                sh 'terraform plan'
            }
        }
        stage('Terraform plan'){
            steps{
                sh 'terraform ${action} --auto-approve'
            }
        }
    }
}