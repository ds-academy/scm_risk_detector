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

// 로그아웃 처리
document.querySelector('.btn-login').addEventListener('click', function() {
    if (confirm('로그아웃 하시겠습니까?')) {
        showMessage('로그아웃 되었습니다.');
        setTimeout(() => {
            window.location.href = '/html/Login.html';
        }, 1500);
    }
});

// 프로필 수정 버튼 처리
document.querySelector('.btn-edit').addEventListener('click', function() {
    window.location.href = "/html/MyPage2.html";
});

// 알림 설정 변경 처리
document.getElementById('riskAlert').addEventListener('change', function() {
    const message = this.checked ? 
        '리스크 알림이 활성화되었습니다.' : 
        '리스크 알림이 비활성화되었습니다.';
    showMessage(message);
});

document.getElementById('priceAlert').addEventListener('change', function() {
    const message = this.checked ? 
        '가격 변동 알림이 활성화되었습니다.' : 
        '가격 변동 알림이 비활성화되었습니다.';
    showMessage(message);
});

// 관심 종목 제거 처리
document.querySelectorAll('.btn-remove').forEach(button => {
    button.addEventListener('click', function() {
        const stockCard = this.closest('.stock-card');
        const stockName = stockCard.querySelector('.stock-name').textContent;
        
        if (confirm(`${stockName}을(를) 관심 종목에서 제거하시겠습니까?`)) {
            stockCard.style.animation = 'fadeOut 0.3s';
            setTimeout(() => {
                stockCard.remove();
                showMessage(`${stockName}이(가) 관심 종목에서 제거되었습니다.`);
            }, 300);
        }
    });
});

// 검색 기능
const searchInput = document.querySelector('.search-bar input');
searchInput.addEventListener('keypress', function(e) {
    if (e.key === 'Enter') {
        const searchTerm = this.value.trim();
        if (searchTerm) {
            // 여기에 검색 처리 로직 추가
            showMessage(`'${searchTerm}' 검색 결과로 이동합니다.`);
            // window.location.href = `/search?q=${encodeURIComponent(searchTerm)}`;
        }
    }
});

// 네비게이션 링크 처리
document.querySelectorAll('.nav-links a').forEach(link => {
    link.addEventListener('click', function(e) {
        if (this.getAttribute('href') === '#') {
            e.preventDefault();
            const page = this.textContent;
            showMessage(`${page} 페이지로 이동합니다.`);
        }
		
    });
});
