pipeline {

	agent any

	environment {
		DOCKERHUB_CREDENTIALS = credentials('Docker-key')
		AWS_ACCESS_KEY_ID     = credentials('Access-Key')
  		AWS_SECRET_ACCESS_KEY = credentials('Secret-Key')
		ARTIFACT_NAME = 'booktracker.json'
		AWS_S3_BUCKET = 'devops-booktracker'
		AWS_EB_APP_NAME = 'book-tracker'
        AWS_EB_ENVIRONMENT_NAME = 'booktracker-env'
        AWS_EB_APP_VERSION = "${BUILD_ID}"
	}

	stages {

		stage('Build') {

			steps {
				//sh 'sudo usermod -a -G docker jenkins'
				
				sh 'docker build -t hayaalnafisa/booktracker .'
			}
//             post {
//                 success {
//                     //archiveArtifacts artifacts: '**/target/**.war', followSymlinks: false
//                     sh 'aws configure set region us-east-1'
//                     sh 'aws s3 cp ./booktracker.json s3://$AWS_S3_BUCKET/$ARTIFACT_NAME'
//                 }
//             }
		}

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push') {

			steps {
				sh 'docker push hayaalnafisa/booktracker'
			}
		}

        stage('Deploy') {
            steps {
                //sh 'aws configure set region us-east-1'
                sh 'aws elasticbeanstalk create-application-version --application-name $AWS_EB_APP_NAME --version-label $AWS_EB_APP_VERSION --source-bundle S3Bucket=$AWS_S3_BUCKET,S3Key=$ARTIFACT_NAME'
                sh 'aws elasticbeanstalk update-environment --application-name $AWS_EB_APP_NAME --environment-name $AWS_EB_ENVIRONMENT_NAME --version-label $AWS_EB_APP_VERSION'
            }
	}
    }
	post {
		always {
			sh 'docker logout'
		}
	}

}
