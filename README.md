# 🥄 맛있는 식단표
> 내가 좋아하는 메뉴에는 하트를! ❤️
> 
> 달력에 식단을 기록하고 자신이 좋아하는 식단을 즐겨찾기에 추가하는 기능을 담은 서비스 입니다.

</br>

- 개발 기간 : 2023. 05. 18 ~ 2023. 05. 30
- 참여 인원 : 개인 프로젝트 
- 디자인 패턴 : MVC

</br>

## 📱 동작 화면
|                            메인 화면                             |                          식단 추가 화면                          |                         일별 식단 리스트                         |
|:----------------------------------------------------------------:|:----------------------------------------------------------------:|:----------------------------------------------------------------:|
| <img src="https://github.com/SunnnySong/Tasty-Menu/assets/85678496/072960e3-1d91-4d02-8df4-93ef9de1b635" width="393"> | <img src="https://github.com/SunnnySong/Tasty-Menu/assets/85678496/1affdf14-e67b-4f1d-9b70-eacfb54f6feb" width="393"> | <img src="https://github.com/SunnnySong/Tasty-Menu/assets/85678496/7408e5b5-4478-4185-adab-d54ea8738db9" width="393"> |

|                      즐겨찾기가 추가된 달력                      |                       즐겨찾기 리스트 확인                       |                          식사 알림 설정                          |
|:----------------------------------------------------------------:|:----------------------------------------------------------------:|:----------------------------------------------------------------:|
| <img src="https://github.com/SunnnySong/Tasty-Menu/assets/85678496/a69df3ac-6b5f-44b2-b2c0-36b3f88eed7e" width="393"> | <img src="https://github.com/SunnnySong/Tasty-Menu/assets/85678496/4017159a-f47a-4789-a40a-cb4132b78c0f" width="393"> | <img src="https://github.com/SunnnySong/Tasty-Menu/assets/85678496/44d3fa40-07e7-4bbf-a8b9-181e21c0b8e2" width="393"> |

</br>

## 🔫 트러블 슈팅
### 1️⃣ 날짜 변경이 자연스러운 캘린더 구현
- 날짜 변경시 자연스러운 사용자 경험을 제공하기 위해 `UICollectionViewDiffableDataSource`을 활용했어요.
- `UICollectionViewDiffableDataSource`는 이전 상태와 변경된 데이터를 비교해 필요한 부분만 업데이트 함으로써 불필요한 UI 갱신을 방지하여 성능을 최적화할 수 있고 애니메이션 효과를 적용할 수 있어요.

</br>

### 2️⃣ MVC의 단점인 Massive Controller 문제 해결
<img src="https://github.com/SunnnySong/Tasty-Menu/assets/85678496/0881a6ae-5b9f-4f88-9881-2d219e6f13ce" width="600">

- MVC 패턴의 한계로써 ‘하나의 책임을 가진 객체'에 어울리지 않는 Massive한 Controller 문제 해결을 위해 고심했어요.
- 객체지향 코드를 구현하기 위해 CalendarViewController를 최소한의 역할로 분류하여 4개의 객체를 독립적으로 생성했어요.
- 분리된 객체들이 모두 CalendarViewController와 상호작용을 했을 시 발생하는 복잡도를 고려하여 이들을 관리하는 역할을 수행하는 CalendarManager 객체 도입했어요. 

</br>

### 3️⃣ 달력에 오늘 날짜 강조 표시하기
- 앱이 처음 실행되었을 때, 오늘 날짜에 강조 표시를 구현하고 싶었어요.
- UICollectionViewCell의 `isSelected` 속성을 활용했어요.
- UICollectionView의 CellProvider 시점에 오늘 날짜인지 판별하고, 오늘 날짜가 맞다면 `selectItem(at:animated:scrollPosition:)` 메서드를 사용해 셀의 `isSelected` 속성을 간접적으로 변경했어요.

</br>
