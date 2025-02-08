<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SPAndTech - 프로필 수정</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="../css/Mainpage.css">
    <link rel="stylesheet" href="../css/Mypage2.css">
</head>
<body>
    <nav class="navbar">
        <div class="logo">
            <i class="fas fa-leaf"></i> SPAndTech
        </div>
        <div class="nav-links">
            <a href="#">홈</a>
            <a href="#" class="active">마이페이지</a>
            <a href="#">설정</a>
            <a href="#">리스크</a>
        </div>
        <div class="search-bar">
            <input type="text" placeholder="종목명, 종목코드 검색">
        </div>
        <button class="btn-login">로그아웃</button>
    </nav>

    <main class="main-content">
        <section class="edit-profile-section">
            <div class="section-header">
                <h2 class="section-title">프로필 수정</h2>
                <p class="section-description">프로필 정보를 수정하고 관리하세요.</p>
            </div>

            <form class="profile-form" method="post" action="saveProfile.jsp" enctype="multipart/form-data">
                <div class="form-image-section">
                    <div class="profile-image-wrapper">
                        <div class="profile-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="image-upload-overlay">
                            <i class="fas fa-camera"></i>
                        </div>
                    </div>
                    <input type="file" id="profileImage" name="profileImage" hidden accept="image/*">
                    <button type="button" class="btn-upload" onclick="document.getElementById('profileImage').click();">이미지 업로드</button>
                </div>

                <div class="form-fields">
                    <div class="form-group">
                        <label for="name">이름</label>
                        <input type="text" id="name" name="name" value="홍길동" class="form-input">
                    </div>

                    <div class="form-group">
                        <label for="email">이메일</label>
                        <input type="email" id="email" name="email" value="hong@example.com" class="form-input" readonly>
                        <p class="input-description">이메일은 변경할 수 없습니다.</p>
                    </div>

                    <div class="form-group">
                        <label for="phone">전화번호</label>
                        <input type="tel" id="phone" name="phone" value="010-1234-5678" class="form-input">
                    </div>

                    <div class="form-group">
                        <label for="userId">아이디</label>
                        <input type="text" id="userId" name="userId" class="form-input">
                    </div>

                    <div class="form-group">
                        <label for="password">비밀번호</label>
                        <input type="password" id="password" name="password" class="form-input">
                    </div>

                    <div class="notification-preferences">
                        <h3>알림 수신 설정</h3>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="emailNotifications" checked>
                                <span>이메일 알림</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="smsNotifications" checked>
                                <span>SMS 알림</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="button" class="btn-cancel" onclick="window.history.back();">취소</button>
                        <button type="submit" class="btn-save">저장하기</button>
                    </div>
                </div>
            </form>
        </section>
    </main>
</body>
</html>
