// 로그인/회원가입 탭 전환 함수
function switchTab(tab) {
    // 탭 스타일 변경
    const tabs = document.querySelectorAll('.auth-tab');
    tabs.forEach(t => t.classList.remove('active'));
    
    // 폼 표시/숨김 처리
    const loginForm = document.getElementById('loginForm');
    const signupForm = document.getElementById('signupForm');
    
    if (tab === 'login') {
        loginForm.style.display = 'flex';
        signupForm.style.display = 'none';
        tabs[0].classList.add('active');
        loginForm.reset();
    } else {
        loginForm.style.display = 'none';
        signupForm.style.display = 'flex';
        tabs[1].classList.add('active');
        signupForm.reset();
    }
}

// 알림 메시지 표시 함수
function showMessage(message, isError = false) {
    const messageDiv = document.createElement('div');
    messageDiv.className = `message ${isError ? 'error' : 'success'}`;
    messageDiv.textContent = message;
    messageDiv.style.position = 'fixed';
    messageDiv.style.top = '20px';
    messageDiv.style.right = '20px';
    messageDiv.style.padding = '15px';
    messageDiv.style.borderRadius = '5px';
    messageDiv.style.backgroundColor = isError ? '#ff4444' : '#00C851';
    messageDiv.style.color = 'white';
    messageDiv.style.zIndex = '1000';

    document.body.appendChild(messageDiv);

    setTimeout(() => {
        messageDiv.remove();
    }, 3000);
}

// 이메일 유효성 검사
function validateEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
}

// 로그인 폼 제출 처리
document.getElementById('loginForm').addEventListener('submit', function(e) {
    e.preventDefault();

    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;

    // 이메일 유효성 검사
    if (!validateEmail(email)) {
        showMessage('유효한 이메일 주소를 입력해주세요.', true);
        return;
    }

    // 비밀번호 길이 검사
    if (password.length < 5) {
        showMessage('비밀번호는 5자 이상이어야 합니다.', true);
        return;
    }

    // 여기에 로그인 요청 처리 코드 추가
    // 예시: 성공 시 메인 페이지로 이동
    showMessage('로그인 성공!');
    setTimeout(() => {
        window.location.href = "/html/Mainpage2.html";
    }, 1500);
});

// 회원가입 폼 제출 처리
document.getElementById('signupForm').addEventListener('submit', function(e) {
    e.preventDefault();

    const name = document.getElementById('signup-name').value;
    const email = document.getElementById('signup-email').value;
    const password = document.getElementById('signup-password').value;
    const passwordConfirm = document.getElementById('signup-password-confirm').value;

    // 입력값 검증
    if (!name.trim()) {
        showMessage('이름을 입력해주세요.', true);
        return;
    }

    if (!validateEmail(email)) {
        showMessage('유효한 이메일 주소를 입력해주세요.', true);
        return;
    }

    if (password.length < 5) {
        showMessage('비밀번호는 5자 이상이어야 합니다.', true);
        return;
    }

    if (password !== passwordConfirm) {
        showMessage('비밀번호가 일치하지 않습니다.', true);
        return;
    }

    // 여기에 회원가입 요청 처리 코드 추가
    // 예시: 성공 시 로그인 탭으로 전환
    showMessage('회원가입 성공! 로그인해주세요.');
    setTimeout(() => {
        switchTab('login');
    }, 1500);
});
