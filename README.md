# 기차 예매 앱

## 📌 소개
이 앱은 Flutter로 만든 기차 예매 앱입니다. 사용자는 출발역과 도착역을 선택한 후 좌석을 예매할 수 있습니다.

---

## ✅ 주요 기능
- 출발역, 도착역 선택
- 출발/도착역이 같을 경우 중복 선택 방지
- 좌석 선택 및 예매
- 예매 완료 시 좌석 예약 처리 (예약 좌석은 다시 선택 불가)
- JSON 파일로 역 정보 로드 (`data/station.json`)

---

## 📁 폴더 구조
lib/

├─ main.dart

├─ page/

│ ├─ home_page.dart

│ ├─ seat_page.dart

│ └─ station_list_page.dart

├─ utils/

│ └─ show_dialog.dart

data/

└─ station.json


