/*
 Navicat Premium Data Transfer

 Source Server         : minitiktok
 Source Server Type    : MariaDB
 Source Server Version : 100608
 Source Host           : localhost:3306
 Source Schema         : minitiktok

 Target Server Type    : MariaDB
 Target Server Version : 100608
 File Encoding         : 65001

 Date: 13/06/2022 07:38:04
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `video_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `create_date` datetime(3) NULL DEFAULT NULL,
  `mmdd` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_comments_user`(`user_id`) USING BTREE,
  CONSTRAINT `fk_comments_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (2, 1, 1, 'this is cool', '2022-06-08 23:45:00.188', NULL);
INSERT INTO `comments` VALUES (3, 1, 1, '测试时间格式', '2022-06-08 23:54:28.524', NULL);
INSERT INTO `comments` VALUES (4, 1, 1, '测试时间格式 02', '2022-06-09 00:17:33.687', '');
INSERT INTO `comments` VALUES (5, 18, 4, 'this is a test', '2022-06-13 00:53:55.432', '');
INSERT INTO `comments` VALUES (6, 17, 5, 'hello world', '2022-06-13 00:59:31.673', '');
INSERT INTO `comments` VALUES (7, 6, 7, 'wow cool', '2022-06-13 01:29:55.998', '');

-- ----------------------------
-- Table structure for favorites
-- ----------------------------
DROP TABLE IF EXISTS `favorites`;
CREATE TABLE `favorites`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NULL DEFAULT NULL,
  `video_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `dolike`(`user_id`, `video_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '点赞关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of favorites
-- ----------------------------
INSERT INTO `favorites` VALUES (3, 1, 2);
INSERT INTO `favorites` VALUES (5, 1, 3);
INSERT INTO `favorites` VALUES (7, 4, 17);
INSERT INTO `favorites` VALUES (6, 4, 18);
INSERT INTO `favorites` VALUES (8, 5, 17);
INSERT INTO `favorites` VALUES (9, 7, 6);
INSERT INTO `favorites` VALUES (11, 10, 17);
INSERT INTO `favorites` VALUES (13, 10, 20);

-- ----------------------------
-- Table structure for follows
-- ----------------------------
DROP TABLE IF EXISTS `follows`;
CREATE TABLE `follows`  (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NULL DEFAULT NULL,
  `follower_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `dofollow`(`user_id`, `follower_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '关注关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of follows
-- ----------------------------
INSERT INTO `follows` VALUES (7, 1, 5);
INSERT INTO `follows` VALUES (8, 1, 7);
INSERT INTO `follows` VALUES (9, 1, 10);
INSERT INTO `follows` VALUES (2, 2, 1);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `pwd` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `follow_count` bigint(20) NULL DEFAULT NULL,
  `follower_count` bigint(20) NULL DEFAULT NULL,
  `created_time` datetime(3) NULL DEFAULT NULL,
  `is_follow` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'huyiqiu', '123456', 1, 3, '2022-01-30 11:00:00.000', NULL);
INSERT INTO `users` VALUES (2, 'huyiqiu2', '123456', 0, 1, '2022-06-05 13:19:53.539', 0);
INSERT INTO `users` VALUES (3, 'huyiqiu3', '123456', 0, 0, '2022-06-05 13:23:19.498', 0);
INSERT INTO `users` VALUES (4, 'test', '123456', 0, 0, '2022-06-13 00:53:28.676', 0);
INSERT INTO `users` VALUES (5, 'bytedance', '123456', 1, 0, '2022-06-13 00:59:10.912', 0);
INSERT INTO `users` VALUES (6, 'tiktok', '123456', 0, 0, '2022-06-13 01:23:12.204', 0);
INSERT INTO `users` VALUES (7, 'test2', '123456', 1, 0, '2022-06-13 01:29:35.364', 0);
INSERT INTO `users` VALUES (10, 'hello', '123456', 1, 0, '2022-06-13 01:44:59.751', 0);

-- ----------------------------
-- Table structure for videos
-- ----------------------------
DROP TABLE IF EXISTS `videos`;
CREATE TABLE `videos`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `play_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '视频播放地址',
  `cover_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '视频封面',
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '视频标题，可以为空',
  `favorite_count` int(11) NOT NULL COMMENT '点赞总数',
  `comments_count` int(11) NOT NULL COMMENT '评论总数',
  `created_time` datetime NOT NULL COMMENT '创建时间 创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '短视频表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of videos
-- ----------------------------
INSERT INTO `videos` VALUES (1, 1, 'http://rcmz8xyya.hd-bkt.clouddn.com/test/IMG_1976.TRIM.mp4', 'http://rcmz8xyya.hd-bkt.clouddn.com/test/cover.png', '', -2, 0, '2022-05-14 10:30:13');
INSERT INTO `videos` VALUES (2, 1, 'http://rcmz8xyya.hd-bkt.clouddn.com/test/IMG_0001.TRIM.mp4', 'http://rcmz8xyya.hd-bkt.clouddn.com/test/cover.png', '', 1, 0, '2022-05-13 10:30:13');
INSERT INTO `videos` VALUES (3, 1, 'http://rcmz8xyya.hd-bkt.clouddn.com/test/RPReplay_Final1622295434.MP4', 'http://rcmz8xyya.hd-bkt.clouddn.com/test/cover.png', '', 0, 0, '2022-05-20 10:30:13');
INSERT INTO `videos` VALUES (4, 1, 'http://rcmz8xyya.hd-bkt.clouddn.com/test/RPReplay_Final1644762833.MP4', 'http://rcmz8xyya.hd-bkt.clouddn.com/test/RPReplay_Final1644762833.MP4?vframe/jpg/offset/1', '', 0, 0, '2022-05-22 10:30:13');
INSERT INTO `videos` VALUES (5, 1, 'http://rcmz8xyya.hd-bkt.clouddn.com/test/IMG_4557.MP4', 'http://rcmz8xyya.hd-bkt.clouddn.com/test/IMG_4557.MP4?vframe/jpg/offset/1', '', 0, 0, '2022-05-17 10:30:13');
INSERT INTO `videos` VALUES (6, 1, 'http://rcmz8xyya.hd-bkt.clouddn.com/test/ScreenRecording_05-16-2018%2021-49-04.MP4', 'http://rcmz8xyya.hd-bkt.clouddn.com/test/ScreenRecording_05-16-2018%2021-49-04.MP4?vframe/jpg/offset/1', '', 1, 1, '2022-05-25 10:30:13');
INSERT INTO `videos` VALUES (7, 1, 'http://rcmz8xyya.hd-bkt.clouddn.com/test/RPReplay_Final1629363391.MP4', 'http://rcmz8xyya.hd-bkt.clouddn.com/test/RPReplay_Final1629363391.MP4?vframe/jpg/offset/1', '', 0, 0, '2022-05-21 10:30:13');
INSERT INTO `videos` VALUES (8, 1, 'http://rcmz8xyya.hd-bkt.clouddn.com/test/59048214c9b64efe48652ee0ce163f.mp4', 'http://rcmz8xyya.hd-bkt.clouddn.com/test/59048214c9b64efe48652ee0ce163f.mp4?vframe/jpg/offset/1', '', 0, 0, '2022-05-12 10:30:13');
INSERT INTO `videos` VALUES (9, 1, 'http://rcmz8xyya.hd-bkt.clouddn.com/test/IMG_8112.TRIM.MP4', 'http://rcmz8xyya.hd-bkt.clouddn.com/test/IMG_8112.TRIM.MP4?vframe/jpg/offset/1', '', 0, 0, '2022-05-18 10:30:13');
INSERT INTO `videos` VALUES (10, 1, 'http://rcmz8xyya.hd-bkt.clouddn.com/test/IMG_3419.mp4', 'http://rcmz8xyya.hd-bkt.clouddn.com/test/IMG_3419.mp4?vframe/jpg/offset/1', '', 0, 0, '2022-05-15 10:30:13');
INSERT INTO `videos` VALUES (11, 1, 'http://rcmz8xyya.hd-bkt.clouddn.com/test/103.MP4', 'http://rcmz8xyya.hd-bkt.clouddn.com/test/103.MP4?vframe/jpg/offset/1', '', 0, 0, '2022-05-11 10:30:13');
INSERT INTO `videos` VALUES (12, 1, 'http://rcmz8xyya.hd-bkt.clouddn.com/test/RPReplay_Final1614076176.MP4', 'http://rcmz8xyya.hd-bkt.clouddn.com/test/RPReplay_Final1614076176.MP4?vframe/jpg/offset/1', '', 0, 0, '2022-05-19 10:30:13');
INSERT INTO `videos` VALUES (13, 1, 'http://rcmz8xyya.hd-bkt.clouddn.com/test/RPReplay_Final1648458806.MP4', 'http://rcmz8xyya.hd-bkt.clouddn.com/test/RPReplay_Final1648458806.MP4?vframe/jpg/offset/1', '', 0, 0, '2022-05-23 10:30:13');
INSERT INTO `videos` VALUES (14, 1, 'http://rcmz8xyya.hd-bkt.clouddn.com/test/IMG_4237.mp4', 'http://rcmz8xyya.hd-bkt.clouddn.com/test/IMG_4237.mp4?vframe/jpg/offset/1', '', 0, 0, '2022-05-16 10:30:13');
INSERT INTO `videos` VALUES (15, 1, 'http://rcmz8xyya.hd-bkt.clouddn.com/test/RPReplay_Final1652082520.MP4', 'http://rcmz8xyya.hd-bkt.clouddn.com/test/RPReplay_Final1652082520.MP4?vframe/jpg/offset/1', '', 0, 0, '2022-05-24 10:30:13');
INSERT INTO `videos` VALUES (16, 1, 'http://rcmz8xyya.hd-bkt.clouddn.com/mergesort.mp4', 'http://rcmz8xyya.hd-bkt.clouddn.com/mergesort.mp4?vframe/jpg/offset/1', '', 0, 0, '2022-06-06 14:02:34');
INSERT INTO `videos` VALUES (17, 1, 'http://rcmz8xyya.hd-bkt.clouddn.com/Fu76nw8tnA4dupCgAawmwNYvBNX0', 'http://rcmz8xyya.hd-bkt.clouddn.com/Fu76nw8tnA4dupCgAawmwNYvBNX0?vframe/jpg/offset/1', '', 3, 1, '2022-06-06 14:49:48');
INSERT INTO `videos` VALUES (18, 1, 'http://rcmz8xyya.hd-bkt.clouddn.com/WeChat_20220606155015.mp4', 'http://rcmz8xyya.hd-bkt.clouddn.com/WeChat_20220606155015.mp4?vframe/jpg/offset/1', '', 1, 1, '2022-06-06 14:50:02');
INSERT INTO `videos` VALUES (20, 10, 'http://rcmz8xyya.hd-bkt.clouddn.com/FtQAnBvHzWYyq70AQ_GP5DOCYyTW', 'http://rcmz8xyya.hd-bkt.clouddn.com/FtQAnBvHzWYyq70AQ_GP5DOCYyTW?vframe/jpg/offset/1', 'bubble sort\n', 1, 0, '2022-06-13 01:45:33');

SET FOREIGN_KEY_CHECKS = 1;
