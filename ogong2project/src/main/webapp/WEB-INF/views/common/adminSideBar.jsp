<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/integration/mainPage">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                <div class="sidebar-brand-text mx-3" name="ogong" style="font-size:15px;">관리자 페이지 나가기</div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">


            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                관리자 페이지
            </div>

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
                    aria-expanded="true" aria-controls="collapseTwo">
                    <i class="fas fa-fw fa-cog"></i>
                    <span style="font-size:13px;">회원 조회</span>
                </a>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded" style="font-size:12px;">
                        <a class="collapse-item" href="/admin/listTotalUser?listType=1">모든 회원</a>
                        <a class="collapse-item" href="/admin/listTotalUser?listType=2">탈퇴한 회원</a>
                        <a class="collapse-item" href="/admin/listTotalUser?listType=3">복구한 회원</a>
                        <a class="collapse-item" href="/admin/listTotalUser?listType=4">정지된 회원</a>
                    </div>
                </div>
            </li>
		<!-- #FFAF00 여기 색-------------------------- -->            

            <!-- Divider -->
            <hr class="sidebar-divider my-0">
        
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo1"
                    aria-expanded="true" aria-controls="collapseTwo">
                    <i class="fas fa-fw fa-cog"></i>
                    <span style="font-size:13px;">신고 조회</span>
                </a>
                <div id="collapseTwo1" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded" style="font-size:12px;">
                        <a class="collapse-item" href="/admin/listUserReport">신고된 사용자</a>
                        <a class="collapse-item" href="/admin/listReport?reportType=1">신고된 게시글</a>
                        <a class="collapse-item" href="/admin/listReport?reportType=2">신고된 답변</a>
                        <a class="collapse-item" href="/admin/listReport?reportType=3">신고된 댓글</a>
                    </div>
                </div>
            </li>            


        </ul>
        <!------------------------------------------------- End of Sidebar ------------------------------------------------------->