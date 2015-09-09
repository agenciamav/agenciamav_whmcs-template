		<footer id="whmcs-footer">
			<div class="container">
				{if $langchange}
				<div id="languagechooser" class="margin-bottom text-center">{$setlanguage}</div>
				{/if}
				<p class="text-center text-muted">
					<span class="form-control-static">
						<a href="https://www.facebook.com/agenciamav" class="disabled text-muted"> <i class="fa fa-facebook-square fa-2x"></i></a>  
						<a href="https://github.com/agenciamav" class="disabled text-muted"> <i class="fa fa-github fa-2x"></i></a>  
						<a href="https://twitter.com/@agenciamav" class="disabled text-muted"> <i class="fa fa-twitter-square fa-2x"></i></a>  
						<a href="https://www.youtube.com/channel/UCbl6lJ0fFrBuQd-zUbEA3Tw" class="disabled text-muted"> <i class="fa fa-youtube-play fa-2x"></i></a>  
						<a href="https://plus.google.com/106906622772059203619/about" class="disabled text-muted"> <i class="fa fa-google-plus-square fa-2x"></i> </a>  
					</span>
					<br>
					<small>Copyright &copy; {$smarty.now|date_format:"%Y"} {$companyname}. Todos os direitos reservados.</small>
				</p>
			</div>
		</footer>
		{$footeroutput}
	</body>
</html>
