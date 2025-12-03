-- Kiểm tra và tạo Database
IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'OE_SOF3012')
BEGIN
    CREATE DATABASE OE_SOF3012;
END
GO

USE OE_SOF3012;
GO

-- 1. Bảng User
CREATE TABLE [User] (
    Id       VARCHAR(50)   PRIMARY KEY,
    Password VARCHAR(50)   NOT NULL,
    Email    VARCHAR(50)   NOT NULL UNIQUE,
    Fullname NVARCHAR(50)  NOT NULL,
    Admin    BIT           DEFAULT 0 -- 1: Admin, 0: User
);
GO

-- 2. Bảng Video
CREATE TABLE Video (
    Id          VARCHAR(20)   PRIMARY KEY, -- Youtube ID
    Titile      NVARCHAR(50)  NOT NULL,
    Poster      VARCHAR(100)  NOT NULL,
    Views       INT           DEFAULT 0,
    Description NVARCHAR(1000),
    Active      BIT           DEFAULT 1 -- 1: Active, 0: Inactive
);
GO

-- 3. Bảng Favorite (Tiểu phẩm yêu thích)
CREATE TABLE Favorite (
    Id          BIGINT        IDENTITY(1,1) PRIMARY KEY,
    UserId      VARCHAR(50)   FOREIGN KEY REFERENCES [User](Id),
    VideoId     VARCHAR(20)   FOREIGN KEY REFERENCES Video(Id),
    LikeDate    DATETIME      DEFAULT GETDATE(),
    UNIQUE (UserId, VideoId) -- Một user chỉ like một video 1 lần
);
GO

-- 4. Bảng Share (Tiểu phẩm chia sẻ)
CREATE TABLE Share (
    Id          BIGINT        IDENTITY(1,1) PRIMARY KEY,
    UserId      VARCHAR(50)   FOREIGN KEY REFERENCES [User](Id),
    VideoId     VARCHAR(20)   FOREIGN KEY REFERENCES Video(Id),
    Emails      VARCHAR(255)  NOT NULL, -- Danh sách email người nhận
    ShareDate   DATETIME      DEFAULT GETDATE()
);
GO

-- Insert dữ liệu mẫu
INSERT INTO [User] (Id, Password, Email, Fullname, Admin) VALUES
('admin', '123', 'admin@oe.com', N'Adminstrator', 1),
('user1', '123', 'user1@gmail.com', N'Nguyễn Văn A', 0),
('user2', '123', 'user2@gmail.com', N'Trần Thị B', 0);

INSERT INTO Video (Id, Titile, Poster, Views, Description) VALUES
('Ytet_bPIRCU', N'Lâu ghê mới gặp', 'poster1.jpg', 105, N'Mô tả tiểu phẩm 1'),
('video2id', N'Tiểu phẩm số 2', 'poster2.jpg', 50, N'Mô tả tiểu phẩm 2'),
('video3id', N'Tiểu phẩm số 3', 'poster3.jpg', 150, N'Mô tả tiểu phẩm 3'),
('video4id', N'Tiểu phẩm số 4', 'poster4.jpg', 200, N'Mô tả tiểu phẩm 4'),
('video5id', N'Tiểu phẩm số 5', 'poster5.jpg', 80, N'Mô tả tiểu phẩm 5'),
('video6id', N'Tiểu phẩm số 6', 'poster6.jpg', 120, N'Mô tả tiểu phẩm 6');


-- 1. Ép lại Collation (Bảng mã) cho các cột tiếng Việt (Quan trọng)
-- Lệnh này giúp cột hỗ trợ tiếng Việt chuẩn, không bị lỗi khi tìm kiếm
ALTER TABLE [Users] ALTER COLUMN Fullname NVARCHAR(50) COLLATE Vietnamese_CI_AS NOT NULL;
ALTER TABLE Video ALTER COLUMN Titile NVARCHAR(255) COLLATE Vietnamese_CI_AS NOT NULL;
ALTER TABLE Video ALTER COLUMN Description NVARCHAR(MAX) COLLATE Vietnamese_CI_AS;
GO

-- 2. Cập nhật lại dữ liệu bị lỗi (Nhớ có chữ N đằng trước)
UPDATE [Users] 
SET Fullname = N'Nguyễn Văn A' 
WHERE Id = 'user1';

UPDATE [Users] 
SET Fullname = N'Trần Thị B' 
WHERE Id = 'user2';

-- Sửa lại các Video
UPDATE Video 
SET Titile = N'Lâu ghê mới gặp', 
    Description = N'Một tiểu phẩm hài hước về tình bạn lâu năm.' 
WHERE Id = 'Ytet_bPIRCU';

UPDATE Video 
SET Titile = N'Tiểu phẩm số 2', 
    Description = N'Mô tả chi tiết cho tiểu phẩm số 2.' 
WHERE Id = 'video2id';

UPDATE Video 
SET Titile = N'Tiểu phẩm số 3', 
    Description = N'Mô tả chi tiết cho tiểu phẩm số 3.' 
WHERE Id = 'video3id';

UPDATE Video 
SET Titile = N'Tiểu phẩm số 4', 
    Description = N'Mô tả chi tiết cho tiểu phẩm số 4.' 
WHERE Id = 'video4id';

UPDATE Video 
SET Titile = N'Tiểu phẩm số 5', 
    Description = N'Mô tả chi tiết cho tiểu phẩm số 5.' 
WHERE Id = 'video5id';

UPDATE Video 
SET Titile = N'Tiểu phẩm số 6', 
    Description = N'Mô tả chi tiết cho tiểu phẩm số 6.' 
WHERE Id = 'video6id';


-- ... Bạn có thể viết thêm các dòng UPDATE cho các video khác tương tự ...
GO

-- 3. Kiểm tra kết quả
SELECT Id, Fullname FROM [Users];
SELECT Id, Titile FROM Video;