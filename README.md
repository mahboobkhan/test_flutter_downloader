# VID_LAB

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

from flask import Flask, request, jsonify
import yt_dlp as youtube_dl
import re

app = Flask(__name__)

# Function to validate URL (YouTube, TikTok, Dailymotion, Vimeo, etc.)
def is_valid_video_url(url):
    video_patterns = [
        r'(https?://)?(www\.)?(youtube|youtu|youtube-nocookie)\.(com|be)/.+',
        r'(https?://)?(www\.)?tiktok\.com/.+',
        r'(https?://)?(www\.)?dailymotion\.com/.+',
        r'(https?://)?(www\.)?vimeo\.com/.+'
    ]
    for pattern in video_patterns:
        if re.match(pattern, url):
            return True
    return False

@app.route('/download', methods=['POST'])
def download_video():
    url = request.json['url']
    
    # Validate URL
    if not is_valid_video_url(url):
        return jsonify({'error': 'Provided URL is not a valid video link.'}), 400
    
    # yt-dlp options (get all available formats)
    ydl_opts = {
        'format': 'all',  # Get all available formats
        'noplaylist': True,  # No playlists
        'nocheckcertificate': True,  # Ignore certificate errors
        'geo_bypass': True,  # Bypass geo-blocking
        'concurrent_fragments': 5,  # Download up to 5 fragments at once
        'limit_rate': '4M',  # Limit download rate to 4 MB/s
        'retries': 5,  # Retry 5 times if a failure occurs
        'fragment_retries': 5,  # Retry failed fragments 5 times
        'keep_fragments': False,  # Delete fragments after completion
        'buffer_size': 1024,  # Buffer size in bytes
        'http_chunk_size': '10M',  # Download chunks of 10 MB at a time
        'outtmpl': '%(title)s.%(ext)s',  # Save file as title.mp4
    }

    try:
        with youtube_dl.YoutubeDL(ydl_opts) as ydl:
            # Extract video information
            info = ydl.extract_info(url, download=False)

            # Response data
            response_data = {
                'title': info.get('title', 'N/A'),
                'uploader': info.get('uploader', 'N/A'),
                'duration': info.get('duration', 'N/A'),
                'view_count': info.get('view_count', 'N/A'),
                'like_count': info.get('like_count', 'N/A'),
                'formats': [],  # List of available formats (all qualities)
            }

            # Iterate over available formats
            for format_info in info.get('formats', []):
                # Video + audio: If both vcodec and acodec are not 'none'
                has_video_audio = format_info.get('vcodec') != 'none' and format_info.get('acodec') != 'none'
                
                # Include all formats
                response_data['formats'].append({
                    'format_id': format_info.get('format_id', 'N/A'),
                    'format_note': format_info.get('format_note', 'N/A'),  # Quality (e.g., 720p, 1080p, etc.)
                    'resolution': format_info.get('resolution', 'N/A'),
                    'filesize': format_info.get('filesize', 'N/A'),
                    'ext': format_info.get('ext', 'N/A'),
                    'fps': format_info.get('fps', 'N/A'),
                    'vcodec': format_info.get('vcodec', 'N/A'),
                    'acodec': format_info.get('acodec', 'N/A'),
                    'url': format_info.get('url', 'N/A'),  # Direct download URL
                    'has_video_audio': has_video_audio  # Flag to indicate combined video+audio
                })

            return jsonify(response_data)
    
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
