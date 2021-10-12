echo 'Building Webclient...'
git checkout webclient
echo 'Merging development into webclient'
git merge development
echo 'Commiting webclient'
git commit -m 'Merge Development into Webclient'
git push
echo 'Building Flutter Web'
flutter build web
echo 'Removing old frontend'
rm -rf ../fluttify-backend/web
echo 'Moving new frontend to backend'
cp -r ./build/web ../fluttify-backend/
echo 'Commiting backend'
cd ../fluttify-backend
git add .
git commit -m "Build webclient"
git push origin
echo 'Checkout development branch'
cd ../09-mobile-sose21
git checkout development
echo 'Build Finished'