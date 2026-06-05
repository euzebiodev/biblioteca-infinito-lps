pipeline {
  agent any

  options {
    disableConcurrentBuilds()
    buildDiscarder(logRotator(numToKeepStr: '10'))
  }

  triggers {
    pollSCM('H/5 * * * *')
  }

  stages {
    stage('Validar arquivos') {
      steps {
        sh '''
          set -eu
          test -f index.html
          test -f cosmos/index.html
          test -f madonna/index.html
          test -f madonna/like-a-prayer/index.html
          test -f qrcodes/cosmos.png
          test -f qrcodes/madonna-like-a-prayer.png

          if find . -name '*.before-*' -o -name '*.bak' -o -name '*.tmp' | grep -q .; then
            echo "Arquivos temporarios ou backups nao devem ser publicados."
            exit 1
          fi
        '''
      }
    }

    stage('Deploy em main') {
      steps {
        sh '''
          set -eu
          if ! git branch -r --contains HEAD | grep -Eq 'origin/main$'; then
            echo "Commit nao pertence a origin/main; deploy ignorado."
            exit 0
          fi

          sudo /usr/local/sbin/deploy-biblioteca-infinito-lps "$WORKSPACE"
        '''
      }
    }
  }
}
