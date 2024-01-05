# ALLCON-FE
- 올콘(ALLCON) 프론트 저장소입니다 ✨

</br>

## 👩‍🚀 Developer
<p>
  <a href="https://github.com/antisdun">
    <img src="https://avatars.githubusercontent.com/u/112616257?v=4" width="130">
  </a>  
  <a href="https://github.com/ekkk1126">
    <img src="https://avatars.githubusercontent.com/u/115553490?v=4" width="130">
  </a> 
</p>

---

</br>

## 이용 규칙
### Process
- 기능을 개발하기 위한 이슈를 생성한다.
- `feat` 브랜치를 생성할 때 브랜치 이름은 다음과 같은 규칙으로 생성합니다.
    - feat/#이슈번호
- `feat` 브랜치는 마지막 `develop` 브랜치로부터 생성합니다.
- 꼭 브랜치를 생성하기 전에 `develop` 브랜치를 `pull` 받습니다.


### Pull Request
- 자신의 브랜치에서 `develop` 브랜치로 PR 을 보내 코드를 합칩니다.

<br>

### 브랜치
- main : 제품으로 출시될 수 있는 브랜치
- develop : 다음 출시 버전을 개발하는 브랜치
    - 오류가 없는 코드만 보내야 한다.

- branch명은 아래의 컨벤션을 맞춘다.<br/>
`master` `develop-fe` `develop-be` `release-*` `hotfix-*` `feature/{issue-number}-{feature-name}` <br/>
예시) `feature/#27`


<br>

### 커밋 컨벤션
- Feat: 새로운 기능 추가, 기존의 기능을 요구 사항에 맞추어 수정
- Fix: 버그 수정
- Build : 빌드 관련 수정
- Docs: 문서 수정, 주석 수정
- Style: 코드 의미에 영향을 주지 않는, 코드 스타일 혹은 포맷팅에 대한 변경사항
- Refactor: 코드 리팩토링
- Comment : 필요 주석 추가 및 수정
- Test: 테스트 코드, 리팩토링 테스트 코드 추가
- Chore: 빌드 업무 수정, 패키지 매니저 수정
- Remove : 파일, 폴더 삭제
- Release : 버전 릴리즈

<br>

### 이슈 컨벤션
- 이슈 제목 앞에 [FEATURE], [BUG]를 붙이기
- 라벨 종류 </br>
`🔨 Feature`, `🐛 Bug`, `🛠️ Refactor`, `🎁 Optional`, </br>
`⚙️ Infra`, `🍑 UI`, `☔️ Test`, `🐶 Docs`, `🌈 Release`

```
## 📍 구현 기능
- 구현한 기능에 대한 설명

## 🛠 작업 내용
- [ ] todo1
- [ ] todo2
- [ ] todo3

## 📢 추가 의논 사항
- 추가적으로 의논할 사항이나 발생한 에러에 대한 설명

## 🚨 주의 사항
- 구현하며 발견한 주의 사항이나 **꼭 확인했으면 하는 로직**에 대한 설명
```

<br>

### PR 템플릿
```
## 📒 개요
<!-- 내용을 적어주세요. -->

## 📍 Issue 번호
<!-- 관련있는 이슈 번호(#n)를 적어주세요. 해당 pull request merge와 함께 이슈를 닫으려면 closed #Issue_number를 적어주세요. -->
> #n

## 🛠️ 작업사항
<!-- 내용을 적어주세요. -->

## 📸 스크린샷(선택)
```







