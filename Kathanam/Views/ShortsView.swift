//
//  ShortsView.swift
//  Kathanam
//
//  Created by Yash's Mackbook on 26/02/25.
//
import SwiftUI
import AVKit

struct ShortsView: View {
    // Replace these URLs with direct MP4 links
    let videoURLs: [URL] = [
        URL(string: "https://rr4---sn-npoe7nez.googlevideo.com/videoplayback?expire=1741447503&ei=7wzMZ4H1G56lir4P4JjQsAc&ip=38.150.112.18&id=o-AEX2cIQpyueD2Xne2iVkbRlyuUDS8n9B_fHENmu28hWC&itag=18&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&bui=AUWDL3wIooqHHvBYTFNRTKsCkElJyQFLnx4PXCyTypCYthR3K6uxjR2_dllnHme2we54RWtvpcO0D7Nu&spc=RjZbScNIASTrfv5jF8PN533zmWWhA-W_2HcApGvs_GbBLNvyZgqz4IfR4NoYZhBhDIUOtA&vprv=1&svpuc=1&mime=video%2Fmp4&ns=5AdU6XRUOm1a7Lz-7wGC3RAQ&rqh=1&gir=yes&clen=408931&ratebypass=yes&dur=5.226&lmt=1718082888827475&fexp=24350590,24350737,24350827,24350961,24351173,24351276,24351283,24351347,24351348,24351377,51326932,51355912,51358316,51385701,51411872&c=WEB&sefc=1&txp=6300224&n=KkRfy94OMq5wUQ&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cbui%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Cns%2Crqh%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&sig=AJfQdSswRQIgNRyam6gUxZgUQ3Qw0qxwUGED82d4tDttKYdsQU0p_0kCIQCVZZIrpI-6UmJHjPkp0xYkdkRHZmIaKudh3QLi0UfQqQ%3D%3D&pot=MnTpudf8H3G7MumBXMPfakCU8zfDxTYa8jFoOolpAzw8ovdGAbv-W9u26xQy4SA0D1QSlJn_uSfaKT3S8TKskn0ZqMulUBCVKpGa3MCTRmFkgjK6Kx2erFZKDSu6Pp8zLi2DWbUrx8jFzqKePFQ4su9-qFZ8qQ%3D%3D&range=0-&title=Learn%20basic%20words%20in%20English%20India%20sign%20language&rm=sn-q4fese7l&rrc=104,80,80&req_id=d3bc9cd52b0ca6e9&ipbypass=yes&cm2rm=sn-ci5gup-h55z7z,sn-h55ey7s&redirect_counter=3&cms_redirect=yes&cmsv=e&met=1741425918,&mh=_9&mip=2401:4900:6291:4bbd:8c05:4c85:2669:42f1&mm=34&mn=sn-npoe7nez&ms=ltu&mt=1741425634&mv=m&mvi=4&pl=48&rms=ltu,au&lsparams=ipbypass,met,mh,mip,mm,mn,ms,mv,mvi,pl,rms&lsig=AFVRHeAwRQIgQegEFWe6rmAbsUIlvrjx5X1_QfPxe_cp8_q2rHhgUpwCIQCuIYOCf9uSwLQ27w_6FtC5vKFXn0AaAQhzmk0BMVn8EA%3D%3D")!, // Example direct MP4 URL
        URL(string: "https://rr4---sn-ab5l6nrr.googlevideo.com/videoplayback?expire=1741448447&ei=nxDMZ8LRGOvt2_gPvuWW-AU&ip=154.195.8.86&id=o-AFpjiqW3GJMdHFrBxt1FpppPEBS_LM9bHmjFNXMjIJqx&itag=137&aitags=133%2C134%2C135%2C136%2C137%2C160%2C242%2C243%2C244%2C247%2C278&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&met=1741426847%2C&mh=UO&mm=31%2C29&mn=sn-ab5l6nrr%2Csn-ab5sznld&ms=au%2Crdu&mv=m&mvi=4&pl=21&rms=au%2Cau&initcwndbps=791250&bui=AUWDL3yFP3HpPihVrBqmEzUeYxeZIUtXiJum6MhNsV5o-rq1c3tDlFd4-Z2HU_O_hweY2lGtc_iyALiK&spc=RjZbSQukYEr2oTXC43Ui6f3fuxDzHQfpdtZNeLVcNbw_eDKg0HXemiFJrssATJw&vprv=1&svpuc=1&mime=video%2Fmp4&ns=N2OPq6f-YzfkTxvXh1rNkPYQ&rqh=1&gir=yes&clen=815444&dur=10.066&lmt=1649437323300631&mt=1741426625&fvip=4&keepalive=yes&fexp=51326932%2C51355912%2C51411872&c=WEB&sefc=1&txp=6319224&n=DEj2pWeqabjtuQ&sparams=expire%2Cei%2Cip%2Cid%2Caitags%2Csource%2Crequiressl%2Cxpc%2Cbui%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Cns%2Crqh%2Cgir%2Cclen%2Cdur%2Clmt&sig=AJfQdSswRQIhAKWf_TnUpCq-gGavpFWduYKlQPeufZivSF0YQ_Jv9yD1AiABqMFCm8sKAN553uzoYBSb3FVBuwX75Kp5ibG3Epp36w%3D%3D&lsparams=met%2Cmh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Crms%2Cinitcwndbps&lsig=AFVRHeAwRAIgHg_AtoJ096bJf8PzrLChsaqhLIv282FLEH6ywz5Rp78CIA8Mx91z2W2640bZ5RyKaUsFAgZVDW2Wy8yfnb7OEDiJ&pot=MnTaaIXMY9vEbtpQ93_wM0Bw6WI8Y_N2-rdC1kY6B6Mm8RmmBvMa8E3vU7nE6Wvvv6mdvzy9QhQydkoWZW41Eh7f_9YJiEUMpE4Qdiqqq8zetStv96VlqtNiinGwNEjsphqVfo1MWIDChM-5VOdA7Owhf8nLbQ%3D%3D&range=0-&title=How%20are%20you?%20/%20Are%20you%20okay?%20/%20I%20am%20fine%20%E2%80%90%20Indian%20Sign%20Language%20|%20ISH%20Shiksha")!, // Example direct MP4 URL
        URL(string: "https://rr3---sn-ab5l6nrs.googlevideo.com/videoplayback?expire=1741448511&ei=3xDMZ6HtCqjAlu8P-dyvwQk&ip=154.212.12.248&id=o-ANrCsTgWLPFfHF4COXMDWbKMG1CETtFE401NqwxEUTHq&itag=18&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&met=1741426911%2C&mh=4J&mm=31%2C26&mn=sn-ab5l6nrs%2Csn-p5qlsn76&ms=au%2Conr&mv=m&mvi=3&pl=22&rms=au%2Cau&initcwndbps=783750&bui=AUWDL3yhvdugWQJThsLbyw9oVoFh_4IaVOzhUPSQfufwE5bEDMyWZS4b-WNT6U-dRInKLOLEJB1JZzzv&spc=RjZbSWbVvqbOEUhkhcvrXUsVs1cTvwgTjOpHwTFsmdggfSHsSYH0k6wpuJ0eH1QoJw&vprv=1&svpuc=1&mime=video%2Fmp4&ns=zifuMPMD1rzM7zEj7rOVXp0Q&rqh=1&cnr=14&ratebypass=yes&dur=18.947&lmt=1697364059313774&mt=1741426381&fvip=3&fexp=51326932%2C51355912%2C51358316%2C51411872&c=WEB&sefc=1&txp=6300224&n=lwk1eaDhZL7Zag&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cbui%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Cns%2Crqh%2Ccnr%2Cratebypass%2Cdur%2Clmt&lsparams=met%2Cmh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Crms%2Cinitcwndbps&lsig=AFVRHeAwRQIgbVmjptwcY4Vuzf8mj-PX--S4XkZO8rEgXjiBmHQDQ38CIQDpjVnbKSc_jqrOd67q1mIOT_0MvYS5u3Gj5FDGuepx2A%3D%3D&sig=AJfQdSswRQIgTQ8MmSN6PB6swUwk6Y885BAj48WOKaOF29rlXdj2-esCIQCEqmt0NhatN2D1FMZoklLpPc1I2V_uKf0nf4J7hharag%3D%3D&pot=MnS40X1L7mr0krjp4R5sA5_t3pfZYPkGYP85BrOdoviANbMzkcOctg6m3O6RFqBIHxO999_3hjLA_wLi8sEVXkGyQK-7eWKHFTzG3VIfynHToHjS2TtFoL90MkVxv5jOE9uU05_HD9lQHBW8oJ9anoyJnmCynQ%3D%3D&range=0-&title=5%20Reasons%20you%20should%20learn%20Indian%20Sign%20Language!")!  // Example direct MP4 URL
    ]
   
    @State private var currentVideoIndex = 0
    @State private var player: AVPlayer!
    @State private var dragOffset = CGSize.zero

    var body: some View {
        ZStack {
            // Background color to match YouTube Shorts
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray]),
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack {
                // Video Player (Full-screen player)
                VideoPlayer(player: AVPlayer(url: videoURLs[currentVideoIndex]))
                    .frame(maxHeight: .infinity)
                    .onAppear {
                        setupPlayer(for: currentVideoIndex)
                    }
                    .onDisappear {
                        player.pause()
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                dragOffset = value.translation
                            }
                            .onEnded { value in
                                if dragOffset.height > 100 { // Swipe down threshold
                                    nextVideo()
                                }
                                dragOffset = .zero
                            }
                    )

            }
        }
        .onAppear {
            setupPlayer(for: currentVideoIndex)
        }
    }

    func setupPlayer(for index: Int) {
        player = AVPlayer(url: videoURLs[index])
        player.play()
    }

    func toggleVideo() {
        if player.rate == 0 {
            player.play()
        } else {
            player.pause()
        }
    }

    func nextVideo() {
        currentVideoIndex = (currentVideoIndex + 1) % videoURLs.count
        setupPlayer(for: currentVideoIndex)
    }
}

struct ShortsView_Previews: PreviewProvider {
    static var previews: some View {
        ShortsView()
    }
}
