pipeline {
    agent any
    stages {
        stage('Build') { 
            agent {
                docker {
                    image 'python:2-alpine' 
                }
            }
            steps {
                sh 'python -m py_compile source/tictactoe.py source/BoardClass.py source/GetPlayerMove.py source/PlayerClass.py source/PlayGameClass.py' 
                stash(name: 'compiled-results', includes: 'source/*.py*') 
            }
        }
		
		stage('Test') { 
            agent {
                docker {
                    image 'qnib/pytest' 
                }
            }
            steps {
                sh 'py.test --junit-xml test-reports/results.xml source/tictactoe_integration_tests.py source/tictactoe_unit_tests.py' 
            }
            post {
                always {
                    junit 'test-reports/results.xml' 
                }
            }
        }
		
		stage('Deliver') { 
            agent any
            environment { 
                VOLUME = '$(pwd)/source:/src'
                IMAGE = 'cdrx/pyinstaller-linux:python2'
            }
            steps {
                dir(path: env.BUILD_ID) { 
                    unstash(name: 'compiled-results') 
                    sh "docker run --rm -v ${VOLUME} ${IMAGE} 'pyinstaller -F tictactoe.py'" 
                }
            }
            post {
                success {
                    archiveArtifacts "${env.BUILD_ID}/source/dist/tictactoe" 
                    sh "docker run --rm -v ${VOLUME} ${IMAGE} 'rm -rf build dist'"
                }
            }
        }
		
		stage('Sanity check') {
            steps {
                input "Does the staging environment look ok?"
            }
        }
		
		stage('Deploy - Production') {
            steps {
			   sh 'chmod +x deploy.sh'
               sh './deploy.sh'
            }
        }
		
		
    }
}