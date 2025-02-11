document.addEventListener('DOMContentLoaded', function() {
    // 이미지 업로드 관련 요소
    const profileImage = document.querySelector('.profile-image');
    const imageUploadOverlay = document.querySelector('.image-upload-overlay');
    const fileInput = document.getElementById('profileImage');
    const uploadButton = document.querySelector('.btn-upload');

    // 이미지 업로드 버튼 클릭 이벤트
    uploadButton.addEventListener('click', function() {
        fileInput.click();
    });

    // 파일 선택 시 이미지 미리보기
    fileInput.addEventListener('change', function(e) {
        if (e.target.files && e.target.files[0]) {
            const reader = new FileReader();
            reader.onload = function(e) {
                // 기존 아이콘 제거
                profileImage.innerHTML = '';
                // 새 이미지 추가
                const img = document.createElement('img');
                img.src = e.target.result;
                img.alt = '프로필 이미지';
                profileImage.appendChild(img);
            };
            reader.readAsDataURL(e.target.files[0]);
        }
    });

    // 폼 제출 전 유효성 검사
    const form = document.querySelector('.profile-form');
    form.addEventListener('submit', function(e) {
        e.preventDefault();

        const name = document.getElementById('name').value;
        const phone = document.getElementById('phone').value;
        const password = document.getElementById('password').value;
        const passwordConfirm = document.getElementById('passwordConfirm').value;

        // 이름 유효성 검사
        if (name.trim() === '') {
            alert('이름을 입력해주세요.');
            return;
        }

        // 전화번호 유효성 검사
        const phoneRegex = /^[0-9]{3}-[0-9]{4}-[0-9]{4}$/;
        if (phone && !phoneRegex.test(phone)) {
            alert('전화번호 형식이 올바르지 않습니다. (예: 010-1234-5678)');
            return;
        }

        // 비밀번호 변경 시 유효성 검사
        if (password || passwordConfirm) {
            if (password !== passwordConfirm) {
                alert('비밀번호가 일치하지 않습니다.');
                return;
            }
            if (password.length < 8) {
                alert('비밀번호는 8자 이상이어야 합니다.');
                return;
            }
        }

        // 모든 유효성 검사 통과 시 폼 제출
        this.submit();
    });

    // 취소 버튼 클릭 시 이전 페이지로 이동
    const cancelButton = document.querySelector('.btn-cancel');
    cancelButton.addEventListener('click', function() {
        window.location.href = 'Mypage.jsp';
    });

    // 전화번호 자동 하이픈 추가
    const phoneInput = document.getElementById('phone');
    phoneInput.addEventListener('input', function(e) {
        let number = e.target.value.replace(/[^0-9]/g, '');
        if (number.length > 3 && number.length <= 7) {
            number = number.substr(0, 3) + '-' + number.substr(3);
        } else if (number.length > 7) {
            number = number.substr(0, 3) + '-' + number.substr(3, 4) + '-' + number.substr(7);
        }
        e.target.value = number;
    });

    // 알림 설정 변경 시 서버에 자동 저장
    const notificationCheckboxes = document.querySelectorAll('.checkbox-group input[type="checkbox"]');
    notificationCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            const type = this.name;
            const value = this.checked;

            // AJAX를 사용하여 서버에 알림 설정 변경 요청
            fetch('UpdateNotificationSettings', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `type=${type}&value=${value}`
            })
            .then(response => response.json())
            .then(data => {
                if (!data.success) {
                    alert('알림 설정 변경에 실패했습니다. 다시 시도해주세요.');
                    this.checked = !value; // 실패 시 체크박스 상태 되돌리기
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('알림 설정 변경 중 오류가 발생했습니다.');
                this.checked = !value; // 오류 발생 시 체크박스 상태 되돌리기
            });
        });
    });
});