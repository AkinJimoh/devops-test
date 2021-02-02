pipeline {
    agent any
    
    tools {nodejs "nodejs"}

    environment {
        registry = "458909167390.dkr.ecr.eu-west-2.amazonaws.com/wipro-p1"
        registryCredential = 'ecr-creds'
        dockerImage = ''
        args = "--network host"
        TF_HOME = tool('terraform')
        TF_INPUT = "0"
        TF_IN_AUTOMATION = "TRUE"
        TF_LOG = ""
        AWS_ACCESS_KEY_ID = credentials('aws_access_key')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
        CONSUL_HTTP_TOKEN = credentials('consul-creds')
        PATH = "$TF_HOME:$PATH"
    }

    stages {
        stage('Clean Up') {
            steps {
                // Clean before build
                cleanWs()
                // We need to explicitly checkout from SCM here
                checkout scm
                echo "Now building ${env.JOB_NAME}..."
            }
        }
        stage('Docker Build') {
            steps {
                dir('assets/'){
                script {
                  dockerImage = docker.build(registry, '--network=host .')
            }
                }
            }
        }
        stage('Docker Deploy') {
            steps{
                script {
                docker.withRegistry("https://" + registry, "ecr:eu-west-2:" + registryCredential ) {
                  dockerImage.push()
                    }
                }
            }
        }
        stage('Remove Unused Image') {
            steps{
            sh "docker rmi $registry"
            }
        }
        stage('Terraform Init') {
            steps {
                sh '''
                    terraform -version
                    terraform init
                '''
            }
        }
        stage('Terrfom Validate') {
            steps {
                sh '''
                    terraform validate
                '''
            }
        }
        stage('Terraform Plan') {
            steps {
                    sh "terraform plan -out wipro-dev-test.tfplan;echo \$? > status"
                    stash name: "wipro-dev-test", includes: "wipro-dev-test.tfplan"
            }
        }
        stage('Terraform Apply'){
            steps {
                script{
                    def apply = false
                    try {
                        input message: 'confirm apply', ok: 'Apply Config'
                        apply = true
                    } catch (err) {
                        apply = false

                            sh "terraform destroy -auto-approve"
                            
                        currentBuild.result = 'UNSTABLE'
                    }
                    if(apply){

                            unstash "wipro-dev-test"
                            sh 'terraform apply wipro-dev-test.tfplan'
                            
                    }
                }
            }
        }
    }
}