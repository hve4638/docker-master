# Docker Master

이 레포지터리의 목적은 docker를 관리하는 별개의 container를 만들고 해당 컨테이너 안에서 모든 도커 관련 처리를 하기 위해 만들어졌습니다

## 방향

- docker out of docker 방식으로 docker 관리
- 호스트와 별개의 ssh를 통해 접속
- 사용 용이성을 위해 이미지는 alpine linux가 아닌 ubuntu를 사용합니다

## 의존성

docker 및 docker-compose가 필요합니다

## Quick Start

```bash
git clone https://github.com/hve4638/docker-master.git
cd docker-master
```

이 저장소를 클론합니다

```bash
./keygen.sh
```

`keygen.sh`를 실행합니다. 이 스크립트는 현재 디렉토리에 `key` 디렉토리를 생성하고 거기에 rsa 키를 추가합니다

```bash
./build.sh
```

`build.sh`를 실행해 도커 이미지를 빌드합니다. 이미지의 이름은 `hve/docker-master` 입니다

`docker-compose.yml` 에서 `volumes:` 아래에 위치한 다음 문자열를 수정합니다

```
      - <your_key_directory>:/vol/key:ro
```

`<your_key_directory>`를 `key` 디렉토리의 절대경로로 변환합니다

```bash
docker-compose up
```

해당 docker-compose를 실행해 hve/docker-master 컨테이너를 실행합니다

ssh 포트는 3022로 열려 있으며, key 디렉토리의 `id_rsa` 파일을 통해 master 계정으로 ssh 연결을 할 수 있습니다

```bash
# 연결 예시
# /home/ubuntu 위치에서 git clone을 수행했다고 가정합니다
ssh -p 3022 master@127.0.0.1 -i /home/ubuntu/docker-master/key/id_rsa
```

## 주의

호스트에서 격리했다고 보안상 완전히 안전한 것이 아닙니다. volume 공유 등으로 여전히 호스트에게 영향을 미칠 수 있습니다
