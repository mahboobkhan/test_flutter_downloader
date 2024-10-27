import 'dart:convert';

class Artist {
  Data? data;
  bool? success;
  String? name;
  int? founded;
  List<String>? members;

  Artist({
    this.data,
    this.success,
    this.name,
    this.founded,
    this.members,
  });

  factory Artist.fromRawJson(String str) => Artist.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        success: json["success"],
        name: json["name"],
        founded: json["founded"],
        members: json["members"] == null
            ? []
            : List<String>.from(json["members"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "success": success,
        "name": name,
        "founded": founded,
        "members":
            members == null ? [] : List<dynamic>.from(members!.map((x) => x)),
      };
}

class Data {
  ItemInfo? itemInfo;
  ShareMeta? shareMeta;
  int? statusCode;
  String? statusMsg;

  Data({
    this.itemInfo,
    this.shareMeta,
    this.statusCode,
    this.statusMsg,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        itemInfo: json["itemInfo"] == null
            ? null
            : ItemInfo.fromJson(json["itemInfo"]),
        shareMeta: json["shareMeta"] == null
            ? null
            : ShareMeta.fromJson(json["shareMeta"]),
        statusCode: json["statusCode"],
        statusMsg: json["statusMsg"],
      );

  Map<String, dynamic> toJson() => {
        "itemInfo": itemInfo?.toJson(),
        "shareMeta": shareMeta?.toJson(),
        "statusCode": statusCode,
        "statusMsg": statusMsg,
      };
}

class ItemInfo {
  ItemStruct? itemStruct;

  ItemInfo({
    this.itemStruct,
  });

  factory ItemInfo.fromRawJson(String str) =>
      ItemInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemInfo.fromJson(Map<String, dynamic> json) => ItemInfo(
        itemStruct: json["itemStruct"] == null
            ? null
            : ItemStruct.fromJson(json["itemStruct"]),
      );

  Map<String, dynamic> toJson() => {
        "itemStruct": itemStruct?.toJson(),
      };
}

class ItemStruct {
  String? aigcDescription;
  bool? isAigc;
  Author? author;
  String? backendSourceEventTracking;
  List<Challenge>? challenges;
  List<dynamic>? channelTags;
  bool? collected;
  List<dynamic>? comments;
  List<Content>? contents;
  String? createTime;
  String? desc;
  bool? digged;
  int? diversificationId;
  List<String>? diversificationLabels;
  int? duetDisplay;
  bool? duetEnabled;
  List<dynamic>? effectStickers;
  bool? forFriend;
  String? id;
  bool? indexEnabled;
  int? itemCommentStatus;
  ItemControl? itemControl;
  String? locationCreated;
  Music? music;
  bool? officalItem;
  bool? originalItem;
  bool? privateItem;
  int? scheduleTime;
  bool? secret;
  bool? shareEnabled;
  Stats? stats;
  StatsV2? statsV2;
  List<dynamic>? stickersOnItem;
  int? stitchDisplay;
  bool? stitchEnabled;
  List<dynamic>? suggestedWords;
  int? takeDown;
  List<TextExtra>? textExtra;
  Video? video;
  List<dynamic>? warnInfo;

  ItemStruct({
    this.aigcDescription,
    this.isAigc,
    this.author,
    this.backendSourceEventTracking,
    this.challenges,
    this.channelTags,
    this.collected,
    this.comments,
    this.contents,
    this.createTime,
    this.desc,
    this.digged,
    this.diversificationId,
    this.diversificationLabels,
    this.duetDisplay,
    this.duetEnabled,
    this.effectStickers,
    this.forFriend,
    this.id,
    this.indexEnabled,
    this.itemCommentStatus,
    this.itemControl,
    this.locationCreated,
    this.music,
    this.officalItem,
    this.originalItem,
    this.privateItem,
    this.scheduleTime,
    this.secret,
    this.shareEnabled,
    this.stats,
    this.statsV2,
    this.stickersOnItem,
    this.stitchDisplay,
    this.stitchEnabled,
    this.suggestedWords,
    this.takeDown,
    this.textExtra,
    this.video,
    this.warnInfo,
  });

  factory ItemStruct.fromRawJson(String str) =>
      ItemStruct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemStruct.fromJson(Map<String, dynamic> json) => ItemStruct(
        aigcDescription: json["AIGCDescription"],
        isAigc: json["IsAigc"],
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
        backendSourceEventTracking: json["backendSourceEventTracking"],
        challenges: json["challenges"] == null
            ? []
            : List<Challenge>.from(
                json["challenges"]!.map((x) => Challenge.fromJson(x))),
        channelTags: json["channelTags"] == null
            ? []
            : List<dynamic>.from(json["channelTags"]!.map((x) => x)),
        collected: json["collected"],
        comments: json["comments"] == null
            ? []
            : List<dynamic>.from(json["comments"]!.map((x) => x)),
        contents: json["contents"] == null
            ? []
            : List<Content>.from(
                json["contents"]!.map((x) => Content.fromJson(x))),
        createTime: json["createTime"],
        desc: json["desc"],
        digged: json["digged"],
        diversificationId: json["diversificationId"],
        diversificationLabels: json["diversificationLabels"] == null
            ? []
            : List<String>.from(json["diversificationLabels"]!.map((x) => x)),
        duetDisplay: json["duetDisplay"],
        duetEnabled: json["duetEnabled"],
        effectStickers: json["effectStickers"] == null
            ? []
            : List<dynamic>.from(json["effectStickers"]!.map((x) => x)),
        forFriend: json["forFriend"],
        id: json["id"],
        indexEnabled: json["indexEnabled"],
        itemCommentStatus: json["itemCommentStatus"],
        itemControl: json["item_control"] == null
            ? null
            : ItemControl.fromJson(json["item_control"]),
        locationCreated: json["locationCreated"],
        music: json["music"] == null ? null : Music.fromJson(json["music"]),
        officalItem: json["officalItem"],
        originalItem: json["originalItem"],
        privateItem: json["privateItem"],
        scheduleTime: json["scheduleTime"],
        secret: json["secret"],
        shareEnabled: json["shareEnabled"],
        stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
        statsV2:
            json["statsV2"] == null ? null : StatsV2.fromJson(json["statsV2"]),
        stickersOnItem: json["stickersOnItem"] == null
            ? []
            : List<dynamic>.from(json["stickersOnItem"]!.map((x) => x)),
        stitchDisplay: json["stitchDisplay"],
        stitchEnabled: json["stitchEnabled"],
        suggestedWords: json["suggestedWords"] == null
            ? []
            : List<dynamic>.from(json["suggestedWords"]!.map((x) => x)),
        takeDown: json["takeDown"],
        textExtra: json["textExtra"] == null
            ? []
            : List<TextExtra>.from(
                json["textExtra"]!.map((x) => TextExtra.fromJson(x))),
        video: json["video"] == null ? null : Video.fromJson(json["video"]),
        warnInfo: json["warnInfo"] == null
            ? []
            : List<dynamic>.from(json["warnInfo"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "AIGCDescription": aigcDescription,
        "IsAigc": isAigc,
        "author": author?.toJson(),
        "backendSourceEventTracking": backendSourceEventTracking,
        "challenges": challenges == null
            ? []
            : List<dynamic>.from(challenges!.map((x) => x.toJson())),
        "channelTags": channelTags == null
            ? []
            : List<dynamic>.from(channelTags!.map((x) => x)),
        "collected": collected,
        "comments":
            comments == null ? [] : List<dynamic>.from(comments!.map((x) => x)),
        "contents": contents == null
            ? []
            : List<dynamic>.from(contents!.map((x) => x.toJson())),
        "createTime": createTime,
        "desc": desc,
        "digged": digged,
        "diversificationId": diversificationId,
        "diversificationLabels": diversificationLabels == null
            ? []
            : List<dynamic>.from(diversificationLabels!.map((x) => x)),
        "duetDisplay": duetDisplay,
        "duetEnabled": duetEnabled,
        "effectStickers": effectStickers == null
            ? []
            : List<dynamic>.from(effectStickers!.map((x) => x)),
        "forFriend": forFriend,
        "id": id,
        "indexEnabled": indexEnabled,
        "itemCommentStatus": itemCommentStatus,
        "item_control": itemControl?.toJson(),
        "locationCreated": locationCreated,
        "music": music?.toJson(),
        "officalItem": officalItem,
        "originalItem": originalItem,
        "privateItem": privateItem,
        "scheduleTime": scheduleTime,
        "secret": secret,
        "shareEnabled": shareEnabled,
        "stats": stats?.toJson(),
        "statsV2": statsV2?.toJson(),
        "stickersOnItem": stickersOnItem == null
            ? []
            : List<dynamic>.from(stickersOnItem!.map((x) => x)),
        "stitchDisplay": stitchDisplay,
        "stitchEnabled": stitchEnabled,
        "suggestedWords": suggestedWords == null
            ? []
            : List<dynamic>.from(suggestedWords!.map((x) => x)),
        "takeDown": takeDown,
        "textExtra": textExtra == null
            ? []
            : List<dynamic>.from(textExtra!.map((x) => x.toJson())),
        "video": video?.toJson(),
        "warnInfo":
            warnInfo == null ? [] : List<dynamic>.from(warnInfo!.map((x) => x)),
      };
}

class Author {
  String? avatarLarger;
  String? avatarMedium;
  String? avatarThumb;
  bool? canExpPlaylist;
  int? commentSetting;
  int? createTime;
  int? downloadSetting;
  int? duetSetting;
  bool? ftc;
  String? id;
  bool? isAdVirtual;
  bool? isEmbedBanned;
  int? nickNameModifyTime;
  String? nickname;
  String? nowInvitationCardUrl;
  bool? openFavorite;
  bool? privateAccount;
  String? recommendReason;
  int? relation;
  String? roomId;
  String? secUid;
  bool? secret;
  String? shortId;
  String? signature;
  int? stitchSetting;
  bool? suggestAccountBind;
  bool? ttSeller;
  String? uniqueId;
  int? uniqueIdModifyTime;
  bool? verified;

  Author({
    this.avatarLarger,
    this.avatarMedium,
    this.avatarThumb,
    this.canExpPlaylist,
    this.commentSetting,
    this.createTime,
    this.downloadSetting,
    this.duetSetting,
    this.ftc,
    this.id,
    this.isAdVirtual,
    this.isEmbedBanned,
    this.nickNameModifyTime,
    this.nickname,
    this.nowInvitationCardUrl,
    this.openFavorite,
    this.privateAccount,
    this.recommendReason,
    this.relation,
    this.roomId,
    this.secUid,
    this.secret,
    this.shortId,
    this.signature,
    this.stitchSetting,
    this.suggestAccountBind,
    this.ttSeller,
    this.uniqueId,
    this.uniqueIdModifyTime,
    this.verified,
  });

  factory Author.fromRawJson(String str) => Author.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        avatarLarger: json["avatarLarger"],
        avatarMedium: json["avatarMedium"],
        avatarThumb: json["avatarThumb"],
        canExpPlaylist: json["canExpPlaylist"],
        commentSetting: json["commentSetting"],
        createTime: json["createTime"],
        downloadSetting: json["downloadSetting"],
        duetSetting: json["duetSetting"],
        ftc: json["ftc"],
        id: json["id"],
        isAdVirtual: json["isADVirtual"],
        isEmbedBanned: json["isEmbedBanned"],
        nickNameModifyTime: json["nickNameModifyTime"],
        nickname: json["nickname"],
        nowInvitationCardUrl: json["nowInvitationCardUrl"],
        openFavorite: json["openFavorite"],
        privateAccount: json["privateAccount"],
        recommendReason: json["recommendReason"],
        relation: json["relation"],
        roomId: json["roomId"],
        secUid: json["secUid"],
        secret: json["secret"],
        shortId: json["shortId"],
        signature: json["signature"],
        stitchSetting: json["stitchSetting"],
        suggestAccountBind: json["suggestAccountBind"],
        ttSeller: json["ttSeller"],
        uniqueId: json["uniqueId"],
        uniqueIdModifyTime: json["uniqueIdModifyTime"],
        verified: json["verified"],
      );

  Map<String, dynamic> toJson() => {
        "avatarLarger": avatarLarger,
        "avatarMedium": avatarMedium,
        "avatarThumb": avatarThumb,
        "canExpPlaylist": canExpPlaylist,
        "commentSetting": commentSetting,
        "createTime": createTime,
        "downloadSetting": downloadSetting,
        "duetSetting": duetSetting,
        "ftc": ftc,
        "id": id,
        "isADVirtual": isAdVirtual,
        "isEmbedBanned": isEmbedBanned,
        "nickNameModifyTime": nickNameModifyTime,
        "nickname": nickname,
        "nowInvitationCardUrl": nowInvitationCardUrl,
        "openFavorite": openFavorite,
        "privateAccount": privateAccount,
        "recommendReason": recommendReason,
        "relation": relation,
        "roomId": roomId,
        "secUid": secUid,
        "secret": secret,
        "shortId": shortId,
        "signature": signature,
        "stitchSetting": stitchSetting,
        "suggestAccountBind": suggestAccountBind,
        "ttSeller": ttSeller,
        "uniqueId": uniqueId,
        "uniqueIdModifyTime": uniqueIdModifyTime,
        "verified": verified,
      };
}

class Challenge {
  String? coverLarger;
  String? coverMedium;
  String? coverThumb;
  String? desc;
  String? id;
  String? profileLarger;
  String? profileMedium;
  String? profileThumb;
  String? title;

  Challenge({
    this.coverLarger,
    this.coverMedium,
    this.coverThumb,
    this.desc,
    this.id,
    this.profileLarger,
    this.profileMedium,
    this.profileThumb,
    this.title,
  });

  factory Challenge.fromRawJson(String str) =>
      Challenge.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Challenge.fromJson(Map<String, dynamic> json) => Challenge(
        coverLarger: json["coverLarger"],
        coverMedium: json["coverMedium"],
        coverThumb: json["coverThumb"],
        desc: json["desc"],
        id: json["id"],
        profileLarger: json["profileLarger"],
        profileMedium: json["profileMedium"],
        profileThumb: json["profileThumb"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "coverLarger": coverLarger,
        "coverMedium": coverMedium,
        "coverThumb": coverThumb,
        "desc": desc,
        "id": id,
        "profileLarger": profileLarger,
        "profileMedium": profileMedium,
        "profileThumb": profileThumb,
        "title": title,
      };
}

class Content {
  String? desc;
  List<TextExtra>? textExtra;

  Content({
    this.desc,
    this.textExtra,
  });

  factory Content.fromRawJson(String str) => Content.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        desc: json["desc"],
        textExtra: json["textExtra"] == null
            ? []
            : List<TextExtra>.from(
                json["textExtra"]!.map((x) => TextExtra.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "desc": desc,
        "textExtra": textExtra == null
            ? []
            : List<dynamic>.from(textExtra!.map((x) => x.toJson())),
      };
}

class TextExtra {
  String? awemeId;
  int? end;
  String? hashtagId;
  String? hashtagName;
  bool? isCommerce;
  int? start;
  int? subType;
  int? type;

  TextExtra({
    this.awemeId,
    this.end,
    this.hashtagId,
    this.hashtagName,
    this.isCommerce,
    this.start,
    this.subType,
    this.type,
  });

  factory TextExtra.fromRawJson(String str) =>
      TextExtra.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TextExtra.fromJson(Map<String, dynamic> json) => TextExtra(
        awemeId: json["awemeId"],
        end: json["end"],
        hashtagId: json["hashtagId"],
        hashtagName: json["hashtagName"],
        isCommerce: json["isCommerce"],
        start: json["start"],
        subType: json["subType"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "awemeId": awemeId,
        "end": end,
        "hashtagId": hashtagId,
        "hashtagName": hashtagName,
        "isCommerce": isCommerce,
        "start": start,
        "subType": subType,
        "type": type,
      };
}

class ItemControl {
  bool? canRepost;

  ItemControl({
    this.canRepost,
  });

  factory ItemControl.fromRawJson(String str) =>
      ItemControl.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemControl.fromJson(Map<String, dynamic> json) => ItemControl(
        canRepost: json["can_repost"],
      );

  Map<String, dynamic> toJson() => {
        "can_repost": canRepost,
      };
}

class Music {
  String? authorName;
  bool? collected;
  String? coverLarge;
  String? coverMedium;
  String? coverThumb;
  int? duration;
  String? id;
  bool? original;
  String? playUrl;
  PreciseDuration? preciseDuration;
  int? scheduleSearchTime;
  String? title;

  Music({
    this.authorName,
    this.collected,
    this.coverLarge,
    this.coverMedium,
    this.coverThumb,
    this.duration,
    this.id,
    this.original,
    this.playUrl,
    this.preciseDuration,
    this.scheduleSearchTime,
    this.title,
  });

  factory Music.fromRawJson(String str) => Music.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Music.fromJson(Map<String, dynamic> json) => Music(
        authorName: json["authorName"],
        collected: json["collected"],
        coverLarge: json["coverLarge"],
        coverMedium: json["coverMedium"],
        coverThumb: json["coverThumb"],
        duration: json["duration"],
        id: json["id"],
        original: json["original"],
        playUrl: json["playUrl"],
        preciseDuration: json["preciseDuration"] == null
            ? null
            : PreciseDuration.fromJson(json["preciseDuration"]),
        scheduleSearchTime: json["scheduleSearchTime"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "authorName": authorName,
        "collected": collected,
        "coverLarge": coverLarge,
        "coverMedium": coverMedium,
        "coverThumb": coverThumb,
        "duration": duration,
        "id": id,
        "original": original,
        "playUrl": playUrl,
        "preciseDuration": preciseDuration?.toJson(),
        "scheduleSearchTime": scheduleSearchTime,
        "title": title,
      };
}

class PreciseDuration {
  double? preciseAuditionDuration;
  double? preciseDuration;
  double? preciseShootDuration;
  double? preciseVideoDuration;

  PreciseDuration({
    this.preciseAuditionDuration,
    this.preciseDuration,
    this.preciseShootDuration,
    this.preciseVideoDuration,
  });

  factory PreciseDuration.fromRawJson(String str) =>
      PreciseDuration.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PreciseDuration.fromJson(Map<String, dynamic> json) =>
      PreciseDuration(
        preciseAuditionDuration: json["preciseAuditionDuration"]?.toDouble(),
        preciseDuration: json["preciseDuration"]?.toDouble(),
        preciseShootDuration: json["preciseShootDuration"]?.toDouble(),
        preciseVideoDuration: json["preciseVideoDuration"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "preciseAuditionDuration": preciseAuditionDuration,
        "preciseDuration": preciseDuration,
        "preciseShootDuration": preciseShootDuration,
        "preciseVideoDuration": preciseVideoDuration,
      };
}

class Stats {
  String? collectCount;
  int? commentCount;
  int? diggCount;
  int? playCount;
  int? shareCount;

  Stats({
    this.collectCount,
    this.commentCount,
    this.diggCount,
    this.playCount,
    this.shareCount,
  });

  factory Stats.fromRawJson(String str) => Stats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        collectCount: json["collectCount"],
        commentCount: json["commentCount"],
        diggCount: json["diggCount"],
        playCount: json["playCount"],
        shareCount: json["shareCount"],
      );

  Map<String, dynamic> toJson() => {
        "collectCount": collectCount,
        "commentCount": commentCount,
        "diggCount": diggCount,
        "playCount": playCount,
        "shareCount": shareCount,
      };
}

class StatsV2 {
  String? collectCount;
  String? commentCount;
  String? diggCount;
  String? playCount;
  String? repostCount;
  String? shareCount;

  StatsV2({
    this.collectCount,
    this.commentCount,
    this.diggCount,
    this.playCount,
    this.repostCount,
    this.shareCount,
  });

  factory StatsV2.fromRawJson(String str) => StatsV2.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StatsV2.fromJson(Map<String, dynamic> json) => StatsV2(
        collectCount: json["collectCount"],
        commentCount: json["commentCount"],
        diggCount: json["diggCount"],
        playCount: json["playCount"],
        repostCount: json["repostCount"],
        shareCount: json["shareCount"],
      );

  Map<String, dynamic> toJson() => {
        "collectCount": collectCount,
        "commentCount": commentCount,
        "diggCount": diggCount,
        "playCount": playCount,
        "repostCount": repostCount,
        "shareCount": shareCount,
      };
}

class Video {
  String? vqScore;
  int? bitrate;
  List<BitrateInfo>? bitrateInfo;
  String? codecType;
  String? cover;
  String? definition;
  String? downloadAddr;
  int? duration;
  String? dynamicCover;
  String? encodeUserTag;
  String? encodedType;
  String? format;
  int? height;
  String? id;
  String? originCover;
  String? playAddr;
  String? ratio;
  String? reflowCover;
  List<String>? shareCover;
  List<dynamic>? subtitleInfos;
  String? videoQuality;

  // VolumeInfo? volumeInfo;
  int? width;
  Map<String, String>? zoomCover;

  Video({
    this.vqScore,
    this.bitrate,
    this.bitrateInfo,
    this.codecType,
    this.cover,
    this.definition,
    this.downloadAddr,
    this.duration,
    this.dynamicCover,
    this.encodeUserTag,
    this.encodedType,
    this.format,
    this.height,
    this.id,
    this.originCover,
    this.playAddr,
    this.ratio,
    this.reflowCover,
    this.shareCover,
    this.subtitleInfos,
    this.videoQuality,
    // this.volumeInfo,
    this.width,
    this.zoomCover,
  });

  factory Video.fromRawJson(String str) => Video.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        vqScore: json["VQScore"],
        bitrate: json["bitrate"],
        bitrateInfo: json["bitrateInfo"] == null
            ? []
            : List<BitrateInfo>.from(
                json["bitrateInfo"]!.map((x) => BitrateInfo.fromJson(x))),
        codecType: json["codecType"],
        cover: json["cover"],
        definition: json["definition"],
        downloadAddr: json["downloadAddr"],
        duration: json["duration"],
        dynamicCover: json["dynamicCover"],
        encodeUserTag: json["encodeUserTag"],
        encodedType: json["encodedType"],
        format: json["format"],
        height: json["height"],
        id: json["id"],
        originCover: json["originCover"],
        playAddr: json["playAddr"],
        ratio: json["ratio"],
        reflowCover: json["reflowCover"],
        shareCover: json["shareCover"] == null
            ? []
            : List<String>.from(json["shareCover"]!.map((x) => x)),
        subtitleInfos: json["subtitleInfos"] == null
            ? []
            : List<dynamic>.from(json["subtitleInfos"]!.map((x) => x)),
        videoQuality: json["videoQuality"],
        // volumeInfo: json["volumeInfo"] == null ? null : VolumeInfo.fromJson(json["volumeInfo"]),
        width: json["width"],
        zoomCover: Map.from(json["zoomCover"]!)
            .map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "VQScore": vqScore,
        "bitrate": bitrate,
        "bitrateInfo": bitrateInfo == null
            ? []
            : List<dynamic>.from(bitrateInfo!.map((x) => x.toJson())),
        "codecType": codecType,
        "cover": cover,
        "definition": definition,
        "downloadAddr": downloadAddr,
        "duration": duration,
        "dynamicCover": dynamicCover,
        "encodeUserTag": encodeUserTag,
        "encodedType": encodedType,
        "format": format,
        "height": height,
        "id": id,
        "originCover": originCover,
        "playAddr": playAddr,
        "ratio": ratio,
        "reflowCover": reflowCover,
        "shareCover": shareCover == null
            ? []
            : List<dynamic>.from(shareCover!.map((x) => x)),
        "subtitleInfos": subtitleInfos == null
            ? []
            : List<dynamic>.from(subtitleInfos!.map((x) => x)),
        "videoQuality": videoQuality,
        // "volumeInfo": volumeInfo?.toJson(),
        "width": width,
        "zoomCover":
            Map.from(zoomCover!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class BitrateInfo {
  int? bitrate;
  String? codecType;
  String? gearName;
  String? mvmaf;
  PlayAddr? playAddr;
  int? qualityType;

  BitrateInfo({
    this.bitrate,
    this.codecType,
    this.gearName,
    this.mvmaf,
    this.playAddr,
    this.qualityType,
  });

  factory BitrateInfo.fromRawJson(String str) =>
      BitrateInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BitrateInfo.fromJson(Map<String, dynamic> json) => BitrateInfo(
        bitrate: json["Bitrate"],
        codecType: json["CodecType"],
        gearName: json["GearName"],
        mvmaf: json["MVMAF"],
        playAddr: json["PlayAddr"] == null
            ? null
            : PlayAddr.fromJson(json["PlayAddr"]),
        qualityType: json["QualityType"],
      );

  Map<String, dynamic> toJson() => {
        "Bitrate": bitrate,
        "CodecType": codecType,
        "GearName": gearName,
        "MVMAF": mvmaf,
        "PlayAddr": playAddr?.toJson(),
        "QualityType": qualityType,
      };
}

class PlayAddr {
  String? dataSize;
  String? fileCs;
  String? fileHash;
  int? height;
  String? uri;
  String? urlKey;
  List<String>? urlList;
  int? width;

  PlayAddr({
    this.dataSize,
    this.fileCs,
    this.fileHash,
    this.height,
    this.uri,
    this.urlKey,
    this.urlList,
    this.width,
  });

  factory PlayAddr.fromRawJson(String str) =>
      PlayAddr.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlayAddr.fromJson(Map<String, dynamic> json) => PlayAddr(
        dataSize: json["DataSize"],
        fileCs: json["FileCs"],
        fileHash: json["FileHash"],
        height: json["Height"],
        uri: json["Uri"],
        urlKey: json["UrlKey"],
        urlList: json["UrlList"] == null
            ? []
            : List<String>.from(json["UrlList"]!.map((x) => x)),
        width: json["Width"],
      );

  Map<String, dynamic> toJson() => {
        "DataSize": dataSize,
        "FileCs": fileCs,
        "FileHash": fileHash,
        "Height": height,
        "Uri": uri,
        "UrlKey": urlKey,
        "UrlList":
            urlList == null ? [] : List<dynamic>.from(urlList!.map((x) => x)),
        "Width": width,
      };
}

/*class VolumeInfo {
  double? loudness;
  int? peak;

  VolumeInfo({
    this.loudness,
    this.peak,
  });

  factory VolumeInfo.fromRawJson(String str) =>
      VolumeInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VolumeInfo.fromJson(Map<String, dynamic> json) => VolumeInfo(
        loudness: json["Loudness"]?.toDouble(),
        peak: json["Peak"],
      );

  Map<String, dynamic> toJson() => {
        "Loudness": loudness,
        "Peak": peak,
      };
}*/

class ShareMeta {
  String? desc;
  String? title;

  ShareMeta({
    this.desc,
    this.title,
  });

  factory ShareMeta.fromRawJson(String str) =>
      ShareMeta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShareMeta.fromJson(Map<String, dynamic> json) => ShareMeta(
        desc: json["desc"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "desc": desc,
        "title": title,
      };
}

class Album {
  String? name;
  ArtistClass? artist;
  List<Track>? tracks;

  Album({
    this.name,
    this.artist,
    this.tracks,
  });

  factory Album.fromRawJson(String str) => Album.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        name: json["name"],
        artist: json["artist"] == null
            ? null
            : ArtistClass.fromJson(json["artist"]),
        tracks: json["tracks"] == null
            ? []
            : List<Track>.from(json["tracks"]!.map((x) => Track.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "artist": artist?.toJson(),
        "tracks": tracks == null
            ? []
            : List<dynamic>.from(tracks!.map((x) => x.toJson())),
      };
}

class ArtistClass {
  String? name;
  int? founded;
  List<String>? members;

  ArtistClass({
    this.name,
    this.founded,
    this.members,
  });

  factory ArtistClass.fromRawJson(String str) =>
      ArtistClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArtistClass.fromJson(Map<String, dynamic> json) => ArtistClass(
        name: json["name"],
        founded: json["founded"],
        members: json["members"] == null
            ? []
            : List<String>.from(json["members"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "founded": founded,
        "members":
            members == null ? [] : List<dynamic>.from(members!.map((x) => x)),
      };
}

class Track {
  String? name;
  int? duration;

  Track({
    this.name,
    this.duration,
  });

  factory Track.fromRawJson(String str) => Track.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        name: json["name"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "duration": duration,
      };
}
